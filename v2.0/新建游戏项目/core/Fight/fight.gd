extends Control
class_name Fight

var 玩家:攻击对象
var 敌人:攻击对象

func _ready() -> void:
	pass

func 添加新牌到战场(player:Player,card:DragControl,index:int):
	var node
	if player==玩家.player:
		node=$"玩家随从"
	if player==敌人.player:
		node=$"敌人随从"
	if node==null:
		Logger.error("获取错误，该player不在这个fight中")
		return
	if !是否有空位(player):
		print("随从太多了,放不下")
		return
	
	if card.get_parent():
		card.reparent(node)
	else:
		node.add_child(card)
	node.move_child(card,min(index,node.get_children().size()-1))
	await get_tree().process_frame

func 获取自己战场中的牌(player:Player)->Array:
	if player==玩家.player:
		return $"玩家随从".get_children().filter(func(node:Control): return node.visible)
	if player==敌人.player:
		return $"敌人随从".get_children().filter(func(node:Control): return node.visible)
	Logger.error("获取错误，该player不在这个fight中")
	return []

func 获取攻击对象(player:Player)->攻击对象:
	if player==玩家.player:
		return 玩家
	if player==敌人.player:
		return 敌人
	Logger.error("错误的获取敌人，该player不在这个fight中")
	return null

func 获取敌人(player:Player)->Player:
	if player==玩家.player:
		return 敌人.player
	if player==敌人.player:
		return 玩家.player
	Logger.error("错误的获取敌人，该player不在这个fight中")
	return null

class 攻击对象:
	var player:Player
	var 当前攻击的随从:DragControl
	var 当前攻击随从是否是立刻攻击:bool=false
	# dic card:card, 是否立刻攻击:false
	var 有空位时召唤对象:Array=[]
	var 有空位时立刻攻击对象:Array=[]
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


func 是否有空位(player:Player)->bool:
	return 获取自己战场中的牌(player).size() < 7

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
	玩家.进入战斗模式(self)
	敌人.进入战斗模式(self)
	_初始化战斗中的牌(玩家,$"玩家随从")
	_初始化战斗中的牌(敌人,$"敌人随从")
	await get_tree().process_frame
	战斗运算()

func 战斗运算():
	while true:
		if 是否在播放动画:
			await get_tree().create_timer(1.0).timeout
			continue
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
				
				当前攻击者.当前攻击随从是否是立刻攻击=false
				if 是否有空位(当前攻击者.player):
					if !当前攻击者.有空位时立刻攻击对象.is_empty():
						var i=当前攻击者.有空位时立刻攻击对象.pop_front()
						var 召唤者=i.card_data.other_data.get_or_add("召唤者",null)
						if 召唤者 and is_instance_valid(召唤者):
							await 添加新牌到战场(当前攻击者.player,i,召唤者.get_parent().get_index()+1)
							当前攻击者.当前攻击的随从=i
							当前攻击者.当前攻击随从是否是立刻攻击=true
					elif !当前攻击者.有空位时召唤对象.is_empty():
						var 空位个数=7-获取自己战场中的牌(当前攻击者.player).size()
						for i in 空位个数:
							var card= 当前攻击者.有空位时召唤对象.pop_front()
							var 召唤者=i.card_data.other_data.get_or_add("召唤者",null)
							var index=-1
							if 召唤者 and is_instance_valid(召唤者):
								index=召唤者.get_parent().get_index()+1
							await 添加新牌到战场(当前攻击者.player,card,index)
					else:
						_获取攻击随从(当前攻击者,所有的牌)
				else:
					_获取攻击随从(当前攻击者,所有的牌)
				if 当前攻击者.当前攻击的随从==null:
					# 攻击力都是0不能进行攻击了
					不能攻击的玩家个数+=1
					当前攻击者=防御者
				else:
					# 随机进行攻击
					不能攻击的玩家个数=0;
					await _随从进行攻击(当前攻击者.当前攻击的随从,当前攻击者,防御者)
					if 当前攻击者.当前攻击的随从.card_data.风怒:
						await _随从进行攻击(当前攻击者.当前攻击的随从,当前攻击者,防御者)
					if 当前攻击者.当前攻击的随从.card_data.超级风怒:
						await _随从进行攻击(当前攻击者.当前攻击的随从,当前攻击者,防御者)
						await _随从进行攻击(当前攻击者.当前攻击的随从,当前攻击者,防御者)
					if !当前攻击者.当前攻击随从是否是立刻攻击:
						# 立刻攻击的随从 不计入随从攻击池中
						当前攻击者=防御者

func _获取攻击随从(当前攻击者:攻击对象,所有的牌):
	# 遍历获取轮到随从攻击
	if 当前攻击者.当前攻击的随从==null:
		for i in 所有的牌:
			var 攻击力=i.card_data.atk_bonus(当前攻击者.player)
			if 攻击力>0:
				当前攻击者.当前攻击的随从=i
				break
	else:
		var index=当前攻击者.当前攻击的随从.get_index()
		当前攻击者.当前攻击的随从=null
		if index>=所有的牌.size()-1:
			# 重头开始
			for i in 所有的牌:
				var 攻击力=i.card_data.atk_bonus(当前攻击者.player)
				if 攻击力>0:
					当前攻击者.当前攻击的随从=i
					break
		else:
			for tempIndex in 所有的牌.size():
				if tempIndex<=index:
					continue
				var i = 所有的牌.get(tempIndex)
				var 攻击力=i.card_data.atk_bonus(当前攻击者.player)
				if 攻击力>0:
					当前攻击者.当前攻击的随从=i
					break

func _初始化战斗中的牌(player:Player,box:HBoxContainer):
	for i in box.get_children():
		i.queue_free()
	for i in player.战场.获取所有节点():
		var newNode=i.duplicate()
		box.add_child(newNode)
	await get_tree().process_frame
	for i in box.get_children():
		i.card_data.触发器_战斗开始时(player)


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
	攻击随从.card_data.hp_process(防御随从.card_data,-防御随从.card_data.atk_bonus(防御者.player),攻击者.player)
	# 防御方
	防御随从.card_data.hp_process(攻击随从.card_data,-攻击随从.card_data.atk_bonus(攻击者.player),防御者.player)

func _伤害计算(胜利者:攻击对象)->int:
	return 10

#region 动画方法

## 移动动画
func move_to_target(panel: Node, target: Node, duration: float) -> void:
	是否在播放动画=true
	var tween = create_tween().set_parallel(true)
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	print(panel.global_position,target.global_position)
	if panel.global_position.y>target.global_position.y:
		tween.tween_property(panel, "global_position", Vector2(target.global_position.x,target.global_position.y+target.size.y), duration)
	else:
		tween.tween_property(panel, "global_position", Vector2(target.global_position.x,target.global_position.y-target.size.y), duration)
	tween.tween_property(panel, "size", target.size, duration)
	await tween.finished
	是否在播放动画=false

## 溶解动画
func 溶解动画(panel: Node):
	是否在播放动画=true
	# 1. 创建ShaderMaterial并设置基础参数
	panel.material.set_shader_parameter("progress", 0.0)  # 初始未溶解
	var tween = create_tween()
	tween.tween_property(panel.material, "shader_parameter/progress", 1.0, 2.0)
	await tween.finished
	是否在播放动画=false


## 抖动动画
func shake_panel(panel: Node, duration: float, strength: float, frequency: float) -> void:
	是否在播放动画=true
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
	是否在播放动画=false


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

#endregion
