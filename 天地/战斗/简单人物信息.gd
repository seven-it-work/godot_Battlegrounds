extends PanelContainer
class_name SimplePeopleInfo

@onready var 集气:= $"VBoxContainer/集气"
@export var player:Player
@export var fight:Fight

func _process(delta: float) -> void:
	if player and fight:
		$"VBoxContainer/HBoxContainer/基础属性/血量".max_value=player.hp_max
		$"VBoxContainer/HBoxContainer/基础属性/血量".value=player.hp_current
		
		$"VBoxContainer/HBoxContainer/基础属性/护盾".max_value=player.hd_max
		$"VBoxContainer/HBoxContainer/基础属性/护盾".value=player.hd_current
		
		if !fight.是否暂停集气:
			$"VBoxContainer/集气".value+=player.集气速度
			if $"VBoxContainer/集气".value>=$"VBoxContainer/集气".max_value:
				$"VBoxContainer/集气".value=0
				# 集气完成
				_集气完成()
	pass


func _集气完成():
	fight.是否暂停集气=true
	print("暂停集气")
	await fight.进行攻击(self)
	print("结束暂停集气")
	fight.是否暂停集气=false
	pass

#region 动画
## 死亡溶解效果
func _死亡溶解效果():
	var tween = create_tween()
	var m=$VBoxContainer.material
	tween.tween_method(func (value): m.set_shader_parameter("progress", value), 0.0, 1.0, 2.0)
	tween.finished.connect(queue_free) # 动画完成后删除节点
	return tween

	

var _initial_position: Vector2  # 初始位置记录
## 抖动动画
# shake_duration: float = 0.5    # 抖动持续时间（秒）
# shake_amplitude: float = 10.0  # 抖动幅度（像素）
# shake_frequency: float = 20.0  # 抖动频率（Hz）
func _抖动动画(
shake_duration: float = 0.5,
shake_amplitude: float = 10.0,
shake_frequency: float = 20.0,
):
	# 记录初始位置（避免多次抖动叠加偏移）
	if not _initial_position:
		_initial_position = position
	# 创建Tween
	var tween = create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)  # 物理帧处理更稳定
	# 计算抖动次数（基于持续时间和频率）
	var shake_count: int = int(shake_duration * shake_frequency)
	# 生成随机方向的抖动关键帧
	for i in range(shake_count):
		var offset = Vector2(
			randf_range(-shake_amplitude, shake_amplitude),
			randf_range(-shake_amplitude, shake_amplitude)
		)
		var time_point = float(i) / shake_frequency
		tween.tween_property(self, "position", _initial_position + offset, 1.0 / shake_frequency).from_current().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
		
	# 最后回到原位
	tween.tween_property(self, "position", _initial_position, 0.1)
	# 动画结束时重置记录
	tween.finished.connect(func():
		position = _initial_position
		_initial_position = Vector2.ZERO
	)
	return tween

var _original_color: Color  # 记录初始颜色
## 触发受击闪烁
# hit_color: Color = Color(1.0, 0.2, 0.2, 1.0)  # 受击时的红色（可调透明度）
# hit_duration: float = 0.3      # 变红时间
# recover_duration: float = 0.5  # 恢复时间
func _受伤动画(
hit_color: Color = Color(1, 0.2, 0.2, 1.0),
hit_duration: float = 0.3,
recover_duration: float = 0.5,
):
	# 如果正在播放，先停止（避免重叠）
	var tween = create_tween()
	# 记录初始颜色（第一次触发时获取）
	if not _original_color:
		_original_color = self_modulate
	# 第一阶段：平滑变红
	tween.tween_property(self, "self_modulate", hit_color, hit_duration)\
		 .set_ease(Tween.EASE_OUT)\
		 .set_trans(Tween.TRANS_SINE)
	
	# 第二阶段：平滑恢复
	tween.tween_property(self, "self_modulate", _original_color, recover_duration)\
		 .set_ease(Tween.EASE_IN_OUT)\
		 .set_trans(Tween.TRANS_QUAD)
	return tween

## 受伤数据
# float_distance: float = 50.0    # 上浮距离
# float_duration: float = 1.0     # 动画持续时间
# font_size: int = 32             # 字体大小
# damage_color: Color = Color(1, 0.2, 0.2)  # 伤害数字颜色
func _展示伤害动画(value: int, target_node: Node,
float_distance: float = 50.0 ,
float_duration: float = 1.0 ,
font_size: int = 32 ,
damage_color: Color = Color(1, 0.2, 0.2),
):
	# 创建Label节点
	var damage_label = Label.new()
	damage_label.text = "-"+str(value)
	damage_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	damage_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	# 设置样式
	damage_label.add_theme_font_size_override("font_size", font_size)
	damage_label.add_theme_color_override("font_color", damage_color)
	
	# 添加到场景
	target_node.add_child(damage_label)
	
	# 初始位置：目标节点中心
	damage_label.position = target_node.size / 2 - damage_label.size / 2
	
	# 创建Tween动画
	var tween = create_tween().set_parallel(true)  # 并行执行多个动画
	
	# 上移动画
	tween.tween_property(damage_label, "position:y", 
		damage_label.position.y - float_distance, float_duration)
	
	# 淡出动画
	tween.tween_property(damage_label, "modulate:a", 
		0.0, float_duration).set_ease(Tween.EASE_OUT)
	
	# 动画结束后删除节点
	tween.finished.connect(func(): damage_label.queue_free())
	
	# 可选：添加轻微缩放效果
	damage_label.scale = Vector2(1.2, 1.2)
	tween.tween_property(damage_label, "scale", Vector2.ONE, float_duration * 0.5)
	tween.finished.connect(func (): damage_label.queue_free())
	return tween


## 攻击动画
# move_duration: float = 1.0    # 移动持续时间
# fade_duration: float = 0.5    # 淡出持续时间（从移动结束时开始）
# font_size: int = 32           # 字体大小
# text_color: Color = Color.WHITE  # 文字颜色
func _攻击动画( end_node: Control,
move_duration: float = 1.0 ,
fade_duration: float = 0.2 ,
font_size: int = 32   ,
text_color: Color = Color.WHITE  ,
):
	# 创建Label节点
	var attack_label = Label.new()
	attack_label.z_index=2
	attack_label.text = "攻击"
	attack_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	attack_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	# 设置样式
	attack_label.add_theme_font_size_override("font_size", font_size)
	attack_label.add_theme_color_override("font_color", text_color)
	
	# 添加到场景（作为当前节点的子节点）
	add_child(attack_label)
	
	# 计算初始位置（start_node中心）
	var start_pos = self.global_position + self.size / 2
	attack_label.global_position = start_pos - attack_label.size / 2
	
	# 计算目标位置（end_node中心）
	var end_pos = end_node.global_position + end_node.size / 2
	
	# 创建Tween动画
	var tween = create_tween()
	
	# 第一阶段：移动到目标位置
	tween.tween_property(attack_label, "global_position", 
		end_pos - attack_label.size / 2, 
		move_duration
	).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
	# 第二阶段：淡出（与移动后半段重叠）
	tween.parallel().tween_property(attack_label, "modulate:a", 
		0.0, 
		fade_duration
	).set_delay(move_duration - fade_duration)  # 延迟开始淡出
	
	# 动画完成后删除节点
	tween.finished.connect(func(): 
		attack_label.queue_free()
	)
	
	# 可选：添加初始缩放效果
	attack_label.scale = Vector2(1.5, 1.5)
	tween.parallel().tween_property(attack_label, "scale", 
		Vector2.ONE, 
		move_duration * 0.5
	)
	return tween
#endregion
