extends Control
class_name Fight

var 玩家:攻击对象
var 敌人:攻击对象

func _ready() -> void:
	pass

func 获取自己战场中的牌(player:Player)->Array:
	if player==玩家.player:
		return $"玩家随从".get_children().filter(func(node:Control): return node.visible)
	if player==敌人.player:
		return $"敌人随从".get_children().filter(func(node:Control): return node.visible)
	Logger.error("获取错误，该player不在这个fight中")
	return []

func 获取敌人(player:Player)->Player:
	if player==玩家.player:
		return 敌人.player
	if player==敌人.player:
		return 玩家.player
	Logger.error("错误的获取敌人，该player不在这个fight中")
	return null

class 攻击对象:
	var player:Player
	var 当前攻击随从的索引:int=0
	func _init(player:Player) -> void:
		self.player=player
	
var 当前攻击者:攻击对象
# 一般是0~1 如果>=2 说明2个玩家都不能攻击，则为平局
var 不能攻击的玩家个数:int=0;
# 播放动画中
var 是否在播放动画:bool=false

var 是否战斗完成标志:bool=false
# 如果 造成伤害=0 则认为是平局
signal 战斗结束(胜利者:攻击对象,失败者:攻击对象,造成伤害:int)


func 开始战斗(玩家:Player,敌人:Player):
	self.玩家=攻击对象.new(玩家)
	self.敌人=攻击对象.new(敌人)
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
	_初始化战斗中的牌(玩家,$"玩家随从")
	_初始化战斗中的牌(敌人,$"敌人随从")
	玩家.进入战斗模式(self)
	敌人.进入战斗模式(self)
	await get_tree().process_frame
	战斗运算()

# todo 存在问题，为什么动画每次的 当前攻击随从 都是第一个呢？
func 战斗运算():
	while true:
		for i in $"玩家随从".get_children():
			if !i.visible:
				i.queue_free()
		for i in $"敌人随从".get_children():
			if !i.visible:
				i.queue_free()
		await get_tree().process_frame
		if 是否战斗完成标志:
			return
		if 不能攻击的玩家个数>=2:
			# 平局
			战斗结束.emit(null,null,0)
		else:
			if 当前攻击者:
				var 所有的牌=获取自己战场中的牌(当前攻击者.player)
				var 防御者=玩家 if 当前攻击者==敌人 else 敌人
				if 所有的牌.size()<=0:
					战斗结束.emit(防御者,当前攻击者,_伤害计算(防御者))
					当前攻击者=null
					return
				# 遍历获取轮到随从攻击
				var 攻击随从:DragControl=null
				var 临时索引位置=当前攻击者.当前攻击随从的索引;
				while true:
					if 当前攻击者.当前攻击随从的索引 >= 所有的牌.size()-1:
						当前攻击者.当前攻击随从的索引=0
						if 当前攻击者.当前攻击随从的索引 == 临时索引位置:
							Logger.error("没有随从可用了")
							return  # 没有可攻击的随从
					var 随从=所有的牌.get(当前攻击者.当前攻击随从的索引)
					if 随从==null:
						if 当前攻击者.当前攻击随从的索引 >= 所有的牌.size()-1:
							Logger.error("错误索引？")
							continue
					var 攻击力=随从.card_data.atk_bonus(当前攻击者.player)
					if 攻击力>0:
						攻击随从=随从
						当前攻击者.当前攻击随从的索引+=1
						break
					else:
						当前攻击者.当前攻击随从的索引+=1
				for i in 所有的牌:
					var 攻击力=i.card_data.atk_bonus(当前攻击者.player)
					if 攻击力>0:
						攻击随从=i
						break
				if 攻击随从==null:
					# 攻击力都是0不能进行攻击了
					不能攻击的玩家个数+=1
					当前攻击者=防御者
				else:
					# 随机进行攻击
					不能攻击的玩家个数=0;
					await _随从进行攻击(攻击随从,当前攻击者,防御者)
					if 攻击随从.card_data.风怒:
						await _随从进行攻击(攻击随从,当前攻击者,防御者)
					if 攻击随从.card_data.超级风怒:
						await _随从进行攻击(攻击随从,当前攻击者,防御者)
						await _随从进行攻击(攻击随从,当前攻击者,防御者)
					当前攻击者=防御者
		
func _初始化战斗中的牌(player:Player,box:HBoxContainer):
	for i in box.get_children():
		i.queue_free()
	for i in player.战场.获取所有节点():
		var newNode=i.duplicate()
		box.add_child(newNode)


func _随从进行攻击(攻击随从:DragControl,攻击者:攻击对象,防御者:攻击对象):
	if 攻击随从.card_data.hp_bonus(攻击者.player)<=0:
		print("没血了，不能继续攻击了")
		return
	# 目标查询（查询嘲讽）
	var list_嘲讽=获取自己战场中的牌(防御者.player).filter(func(card:DragControl): return card.card_data.嘲讽)
	if list_嘲讽.size()>0:
		# 随机选一个
		var defender_minion:DragControl=list_嘲讽.pick_random() as DragControl
		生命计算(攻击随从,攻击者,defender_minion,防御者)
		return
	# 目标查询（忽略掉潜行的）
	var list_minion=获取自己战场中的牌(防御者.player).filter(func(card:DragControl): return !card.card_data.潜行)
	if list_minion.size()>0:
		# 随机选一个
		var defender_minion:DragControl=list_minion.pick_random() as DragControl
		await  生命计算(攻击随从,攻击者,defender_minion,防御者)
		return
	print("对方貌似没有随从了")

func 生命计算(攻击随从:DragControl,攻击者:攻击对象,防御随从:DragControl,防御者:攻击对象):
	Logger.debug("%s对%s进行攻击"%[攻击随从.card_data.name_str,防御随从.card_data.name_str])
	await start_animation_sequence(攻击随从,防御随从)
	print("动画播放完成，进行数据计算")
	# 攻击方生命值-
	攻击随从.card_data.hp_process(防御随从,-防御随从.card_data.atk_bonus(防御者.player),攻击者.player)
	# 防御方
	防御随从.card_data.hp_process(攻击随从,-攻击随从.card_data.atk_bonus(攻击者.player),防御者.player)

func _伤害计算(胜利者:攻击对象)->int:
	return 10

## 移动动画
func move_to_target(panel: Node, target: Node, duration: float) -> void:
	var tween = create_tween().set_parallel(true)
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	print(panel.global_position,target.global_position)
	if panel.global_position.y>target.global_position.y:
		tween.tween_property(panel, "global_position", Vector2(target.global_position.x,target.global_position.y+target.size.y), duration)
	else:
		tween.tween_property(panel, "global_position", Vector2(target.global_position.x,target.global_position.y-target.size.y), duration)
	tween.tween_property(panel, "size", target.size, duration)
	await tween.finished

## 抖动动画
func shake_panel(panel: Node, duration: float, strength: float, frequency: float) -> void:
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


## 返回原位动画
func return_to_original(panel: Node,original_position,original_size, duration: float) -> void:
	var tween = create_tween().set_parallel(true)
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(panel, "global_position", original_position, duration)
	tween.tween_property(panel, "size", original_size, duration)
	
	await tween.finished

func start_animation_sequence(panel_a,panel_b):
	是否在播放动画=true
	var original_position = panel_a.global_position
	var original_size = panel_a.size
	#var parent=panel_a.get_parent()
	#var index= panel_a.get_index()
	#panel_a.reparent(self)
	# 1. 移动到目标位置
	await move_to_target(panel_a, panel_b, 0.5)
	
	# 2. 播放抖动动画
	await shake_panel(panel_b, 0.3, 10.0, 0.8)
	
	# 3. 返回原位
	await return_to_original(panel_a,original_position,original_size, 0.4)
	#panel_a.reparent(parent)
	#parent.move_child(panel_a,index)
	#await get_tree().process_frame
	print("播放完成")
	是否在播放动画=false
