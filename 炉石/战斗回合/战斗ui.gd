extends Control


var 玩家:FightPlayer
var 敌人:FightPlayer
var 当前攻击者:FightPlayer

func 开始战斗(player:Player,target:Player):
	玩家=FightPlayer.new(player)
	敌人=FightPlayer.new(target)
	
	# 判断先手,谁的怪多 谁先手
	if self.玩家.player.战场.获取所有节点().size()==self.敌人.player.战场.获取所有节点().size():
		# 一样 随机顺序
		if randi_range(0,1)==0:
			当前攻击者=self.玩家
		else:
			当前攻击者=self.敌人
	elif self.玩家.player.战场.获取所有节点().size()>self.敌人.player.战场.获取所有节点().size():
		当前攻击者=self.玩家
	else:
		当前攻击者=self.敌人
		
	# 战斗随从初始化
	_初始化战斗中的牌(玩家,$"PanelContainer/VBoxContainer/玩家随从")
	_初始化战斗中的牌(敌人,$"PanelContainer/VBoxContainer/玩家随从")
	pass

func _初始化战斗中的牌(player:FightPlayer,box:HBoxContainer):
	for i in box.get_children():
		i.queue_free()
	# 获取player的战场中的随从


func 获取玩家随从(player:FightPlayer):
	var 容器:HBoxContainer
	if player==玩家:
		容器=$"PanelContainer/VBoxContainer/玩家随从"
	if player==敌人:
		容器=$"PanelContainer/VBoxContainer/敌人随从"
	if 容器:
		return 容器.get_children().filter(func(item:Node): return item.visible)
	printerr("错误获取玩家随从")
	
func 战斗运算():
	while true:
		if 是否在播放动画():
			await get_tree().create_timer(1.0).timeout
			continue
	pass


#region 动画方法
var 播放动画队列:Array[String]=[]


func 是否在播放动画()->bool:
	return !播放动画队列.is_empty()

## 移动动画
func move_to_target(panel: Node, target: Node, duration: float) -> void:
	播放动画队列.append("move_to_target")
	var tween = create_tween().set_parallel(true)
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	print(panel.global_position,target.global_position)
	if panel.global_position.y>target.global_position.y:
		tween.tween_property(panel, "global_position", Vector2(target.global_position.x,target.global_position.y+target.size.y), duration)
	else:
		tween.tween_property(panel, "global_position", Vector2(target.global_position.x,target.global_position.y-target.size.y), duration)
	tween.tween_property(panel, "size", target.size, duration)
	await tween.finished
	播放动画队列.pop_front()

## 溶解动画
func 溶解动画(panel: Node):
	播放动画队列.append("溶解动画")
	# 1. 创建ShaderMaterial并设置基础参数
	panel.material.set_shader_parameter("progress", 0.0)  # 初始未溶解
	var tween = create_tween()
	tween.tween_property(panel.material, "shader_parameter/progress", 1.0, 2.0)
	await tween.finished
	播放动画队列.pop_front()


## 抖动动画
func shake_panel(panel: Node, duration: float, strength: float, frequency: float) -> void:
	播放动画队列.append("抖动动画")
	var original_pos = panel.global_position
	var tween = create_tween()
	
	# 创建8个随机方向（可调整数量）
	var directions = []
	for i in range(8):
		directions.append(Vector2.RIGHT.rotated(TAU * i/8 + randf_range(-0.2, 0.2)))
	
	# 随机选择抖动方向序列
	var shake_sequence = []
	for i in range(ceil(duration * 10)):  # 每秒10次抖动
		shake_sequence.append(directions[randi() % directions.size()])
	
	# 执行抖动动画
	for dir in shake_sequence:
		var offset = dir * strength * randf_range(0.8, 1.2)
		var shake_duration = duration / shake_sequence.size()
		
		tween.tween_property(panel, "global_position", 
							original_pos + offset, 
							shake_duration * 0.4).set_ease(Tween.EASE_OUT)
		tween.tween_property(panel, "global_position", 
							original_pos, 
							shake_duration * 0.6).set_ease(Tween.EASE_IN)
	
	await tween.finished
	播放动画队列.pop_front()


## 返回原位动画
func return_to_original(panel: Node,original_position,original_size, duration: float) -> void:
	播放动画队列.append("return_to_original")
	var tween = create_tween().set_parallel(true)
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(panel, "global_position", original_position, duration)
	tween.tween_property(panel, "size", original_size, duration)
	
	await tween.finished
	播放动画队列.pop_front()
	
func start_animation_sequence(panel_a,panel_b):
	播放动画队列.append("start_animation_sequence")
	var original_position = panel_a.global_position
	var original_size = panel_a.size
	# 1. 移动到目标位置
	await move_to_target(panel_a, panel_b, 0.5)
	
	# 2. 播放抖动动画
	await shake_panel(panel_b, 0.3, 10.0, 0.8)
	
	# 3. 返回原位
	await return_to_original(panel_a,original_position,original_size, 0.4)
	print("播放完成")
	播放动画队列.pop_front()

#endregion
