extends Control
class_name Fight

var 玩家:攻击对象
var 敌人:攻击对象

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
	玩家.进入战斗模式()
	敌人.进入战斗模式()

func 动态处理ui与战斗中的牌对应关系():
	if 敌人:
		for i in 敌人.player.获取战斗中的牌().size():
			var ui中的牌=$"敌人随从".get_child(i)
			var 战斗中的牌=敌人.player.获取战斗中的牌().get(i)
			if ui中的牌.uuid!=战斗中的牌.uuid:
				# 准备清理重新处理
				_重新处理ui($"敌人随从",敌人.player.获取战斗中的牌())
				pass
	if 玩家:
		for i in 玩家.player.获取战斗中的牌().size():
			var ui中的牌=$"玩家随从".get_child(i)
			var 战斗中的牌=玩家.player.获取战斗中的牌().get(i)
			if ui中的牌.uuid!=战斗中的牌.uuid:
				# 准备清理重新处理
				_重新处理ui($"玩家随从",玩家.player.获取战斗中的牌())
				pass
	pass

func _重新处理ui(ui:HBoxContainer,list:Array):
	print("_重新处理ui")
	for i in ui.get_children():
		i.queue_free()
	for i in list:
		var newNode=i.duplicate()
		ui.add_child(newNode)
	pass

func _process(delta: float) -> void:
	if 是否战斗完成标志:
		return
	动态处理ui与战斗中的牌对应关系()
	if 是否在播放动画:
		# 动画处理
		pass
	else:
		if 不能攻击的玩家个数>=2:
			# 平局
			战斗结束.emit(null,null,0)
		else:
			if 当前攻击者:
				var 所有的牌=当前攻击者.player.获取战斗中的牌()
				var 防御者=玩家 if 当前攻击者==敌人 else 敌人
				if 所有的牌.size()<=0:
					战斗结束.emit(防御者,当前攻击者,_伤害计算(防御者))
					当前攻击者=null
					return
				# 遍历获取轮到随从攻击
				var 攻击随从:DragControl=null
				var 临时索引位置=当前攻击者.当前攻击随从的索引;
				# todo 这里用ai处理一下
				# 炉石酒馆中随从攻击的逻辑：一个数组中有很多随从，随从按从左到右依次攻击。如果攻击力为0则跳过让下一个行攻击。如果轮了一圈仍然没有找到可以发起攻击的随从则认为没有可攻击的随从了。
				# 你要实现1、选择出可以攻击的随从。2、记录好攻击的位置当下一轮攻击时，进行依次处理。
				#给你举个例子 A玩家有 [a,b,c,d]4个随从 B玩家有[1,2,3,4,5]个随从，A的a攻击B的1 A的a死亡了就移除了 A还剩[b,c,d] B的1攻击A的b B的1死亡了 A的b死亡了。该A的c攻击B的4,B的4死亡了。B的2 攻击 A的d
				# B的2死亡了，B还剩[3,5]，A的d攻击B的3，B的3死亡了。B的5攻击A的cA的c死亡了，A的d攻击B的5，B的5攻击A的d 两个都是为了。这样一个逻辑。
				while true:
					var 随从=所有的牌.get(当前攻击者.当前攻击随从的索引)
					if 随从==null:
						if 当前攻击者.当前攻击随从的索引 >= 所有的牌.size()-1:
							当前攻击者.当前攻击随从的索引=0
							continue
					var 攻击力=随从.card_data.atk_bonus(当前攻击者.player)
					if 攻击力>0:
						攻击随从=随从
						当前攻击者.当前攻击随从的索引+=1
						break
					else:
						当前攻击者.当前攻击随从的索引+=1
					if 当前攻击者.当前攻击随从的索引 >= 所有的牌.size()-1:
						当前攻击者.当前攻击随从的索引=0
					if 临时索引位置==当前攻击者.当前攻击随从的索引:
						# 轮转一圈了都没有
						break
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
					_随从进行攻击(攻击随从,当前攻击者,防御者)
					if 攻击随从.card_data.风怒:
						_随从进行攻击(攻击随从,当前攻击者,防御者)
					if 攻击随从.card_data.超级风怒:
						_随从进行攻击(攻击随从,当前攻击者,防御者)
						_随从进行攻击(攻击随从,当前攻击者,防御者)
					当前攻击者=防御者
	pass

func _随从进行攻击(攻击随从:DragControl,攻击者:攻击对象,防御者:攻击对象):
	if 攻击随从.card_data.hp_bonus(攻击者.player)<=0:
		print("没血了，不能继续攻击了")
		return
	# 目标查询（查询嘲讽）
	var list_嘲讽=防御者.player.获取战斗中的牌().filter(func(card:DragControl): return card.card_data.嘲讽)
	if list_嘲讽.size()>0:
		# 随机选一个
		var defender_minion:DragControl=list_嘲讽.pick_random() as DragControl
		生命计算(攻击随从,攻击者,defender_minion,防御者)
		return
	# 目标查询（忽略掉潜行的）
	var list_minion=防御者.player.获取战斗中的牌().filter(func(card:DragControl): return !card.card_data.潜行)
	if list_minion.size()>0:
		# 随机选一个
		var defender_minion:DragControl=list_minion.pick_random() as DragControl
		生命计算(攻击随从,攻击者,defender_minion,防御者)
		return
	print("对方貌似没有随从了")

func 生命计算(攻击随从:DragControl,攻击者:攻击对象,防御随从:DragControl,防御者:攻击对象):
	Logger.debug("%s对%s进行攻击"%[攻击随从.card_data.name_str,防御随从.card_data.name_str])
	await start_animation_sequence(攻击随从,防御随从)
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
	
	tween.tween_property(panel, "global_position", target.global_position, duration)
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
	print("播放攻击动画")
	是否在播放动画=true
	var original_position = panel_a.global_position
	var original_size = panel_a.size
	# 1. 移动到目标位置
	await move_to_target(panel_a, panel_b, 0.5)
	
	# 2. 播放抖动动画
	await shake_panel(panel_b, 0.3, 10.0, 0.8)
	
	# 3. 返回原位
	await return_to_original(panel_a,original_position,original_size, 0.4)
	print("播放完成")
	是否在播放动画=false


func _move_panel_to_panel(a, b, duration: float = 0.5) -> void:
	# 创建 Tween 动画
	var tween = create_tween()
	
	# 设置动画过渡效果和缓动类型
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	
	# 记录初始属性
	var start_pos = a.global_position
	var start_size = a.size
	
	# 计算目标位置（将 a 移动到 b 的位置）
	var target_pos = b.global_position
	var target_size = b.size
	
	# 设置动画
	tween.tween_property(a, "global_position", target_pos, duration)
	tween.parallel().tween_property(a, "size", target_size, duration)
	
	await tween.finished
