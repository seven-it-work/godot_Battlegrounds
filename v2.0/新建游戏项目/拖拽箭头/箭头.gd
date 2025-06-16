extends Control

# === 可配置参数 ===


# === 运行时变量 ===
var arrows: Array[Sprite2D] = []          # 存储所有箭头
var curve: Curve2D = Curve2D.new()        # 动态曲线
var last_valid_positions := [Vector2.ZERO, Vector2.ZERO]
var last_valid_dir := Vector2.RIGHT
var min_separation: float = 5.0  # 两点最小间距
# 弯曲度
var curve_tension: float = 5.0

func _ready():
	# 初始化所有箭头
	for i in range(19):
		var sprite=Sprite2D.new()    #新建 Sprite 节点
		add_child(sprite)          #添加到场景里
		arrows.append(sprite)        #添加到数组里
		sprite.texture=load("uid://cxkg7pe47u2kp")  #把图片换成箭头1
		sprite.scale=Vector2(1,1)*(0.2+float(i)/18*0.8) #改变缩放，根据杀戮尖塔，箭头是一节节越来越大的
		sprite.offset=Vector2(-25,0)  #由于我画的图片中心点在箭头中间，
		
	#最后生成终点的箭头，用箭头2的图片
	var sprite=Sprite2D.new()   
	add_child(sprite)
	arrows.append(sprite)
	sprite.texture=load("uid://cxkg7pe47u2kp")
	sprite.offset=Vector2(-30,0)
func update_curve(开始位置,结束位置):
	var dir = 结束位置 - 开始位置
	var dist = dir.length()
	var node_count=arrows.size()
	
	# 安全处理距离过近的情况
	if dist < min_separation:
		_handle_degenerate_case(开始位置,结束位置,dir)
		return
	
	# 正常曲线更新
	last_valid_dir = dir.normalized()
	curve.clear_points()
	
	# 构建带微小弯曲的曲线
	var perp = Vector2(-last_valid_dir.y, last_valid_dir.x) * curve_tension
	curve.add_point(开始位置, Vector2.ZERO, perp)
	curve.add_point(结束位置, -perp, Vector2.ZERO)
	
	# 更新箭头
	var baked_length = curve.get_baked_length()
	for i in range(node_count):
		var t = float(i) / max(node_count - 1, 1)
		arrows[i].global_position = curve.sample_baked(t * baked_length)
		# 超稳定角度计算
		var target_angle = _calculate_safe_angle(i, t, baked_length)
		arrows[i].rotation = target_angle

func _calculate_safe_angle(i: int, t: float, curve_len: float) -> float:
	var node_count=arrows.size()
	# 首尾节点强制使用直线方向
	if i == 0 or i == node_count - 1:
		return last_valid_dir.angle()
	
	# 中间节点使用5点采样法
	var sample_dist = min(0.02 * curve_len, curve_len / 4)
	var points = []
	for offset in [-2, -1, 0, 1, 2]:
		points.append(curve.sample_baked(clamp(t + offset*sample_dist/curve_len, 0, 1) * curve_len))
	
	# 最小二乘法拟合切线
	var sum = Vector2.ZERO
	for j in range(1, points.size()):
		sum += (points[j] - points[j-1]).normalized()
	return (sum / (points.size() - 1)).angle()

func _handle_degenerate_case(开始位置,结束位置,dir: Vector2):
	var node_count=arrows.size()
	# 两点重合/过近时的处理
	var base_pos = 开始位置 if dir.length_squared() < 0.1 else 结束位置
	for i in range(node_count):
		arrows[i].global_position = base_pos + last_valid_dir * i * min_separation
		arrows[i].rotation = last_valid_dir.angle()	
