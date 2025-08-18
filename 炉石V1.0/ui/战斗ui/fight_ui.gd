extends Control
class_name FightUI

var 当前攻击者:Player
var 玩家:Player
var 敌人:Player
## 未开始 战斗中 结束了
var _战斗状态:String="未开始"
var 动画播放队列:Array[Tween]=[]
var 是否正在播放动画:int=0

@onready var 敌人容器:=$"PanelContainer/VBoxContainer/PanelContainer/敌人容器"
@onready var 玩家容器:=$"PanelContainer/VBoxContainer/PanelContainer2/玩家容器"

signal 战斗结束信号(是否平局:bool,胜利者:Player,失败者:Player)

func _是否是敌人(player:Player)->bool:
	return player==敌人


func _process(delta: float) -> void:
	## 存在问题。动画和数据不一致。动画没有播放完 已经死亡 free了
	if 是否正在播放动画!=0:
		return
	if !动画播放队列.is_empty():
		var 动画=动画播放队列.pop_front() as Tween
		if  动画.is_running():
			是否正在播放动画+=1
			await 动画.finished
			是否正在播放动画-=1
		return
	if 是否正在删除:
		return
	if _战斗状态=="战斗中":
		_战斗处理()

func _战斗处理():
	_战斗判断()
	if _战斗状态=="战斗中":
		_当前攻击者进行攻击()
		# 攻击交换
		当前攻击者=获取敌人(当前攻击者)

func _当前攻击者进行攻击():
	## 如果当前攻击者的攻击力都为0，则无法进行攻击
	if 当前攻击者.战斗中的随从.filter(func(item:BaseMinion): return item.获取带加成属性().x>0).size()<=0:
		return
	var 攻击者=当前攻击者 as Player
	var 防御者=获取敌人(当前攻击者)
	var 攻击随从=_获取攻击随从(攻击者) as BaseMinion
	if 攻击随从.获取带加成属性().x==0:
		# 攻击力为0无法攻击
		print("错误了，不应该选择出攻击为0的随从")
		return
	攻击随从.是否攻击过=true
	if 攻击随从.获取风怒():
		for i in 2:
			await _进行攻击(攻击者,防御者,攻击随从)
	elif 攻击随从.获取超级风怒():
		for i in 3:
			await _进行攻击(攻击者,防御者,攻击随从)
	else:
		await _进行攻击(攻击者,防御者,攻击随从)

func _进行攻击(
	攻击者:Player,
	防御者:Player,
	攻击随从:BaseMinion,
	):
	if 攻击随从.current_hp<=0:
		# 已经死亡了
		return
	var 防御随从=_获取防御随从(防御者) as BaseMinion
	if 防御随从==null:
		# 没有防御随从，无法攻击
		return
	await 攻击随从.攻击其他随从(防御随从)

func _获取防御随从(player:Player)->BaseMinion:
	if player.战斗中的随从.is_empty():
		return null
	# 排查潜行随从
	var 随从列表=player.战斗中的随从.filter(func(item:CardEntity): return !item.获取潜行())
	if 随从列表.is_empty():
		return null
	# 过滤嘲讽从
	var 嘲讽随从=随从列表.filter(func(item:CardEntity): return item.获取嘲讽())
	if 嘲讽随从.is_empty():
		# 随机选择
		var 结果=随从列表.pick_random()
		return 结果
	return 嘲讽随从.pick_random()

func _获取攻击随从(player:Player)->BaseMinion:
	if player.战斗中的随从.is_empty():
		printerr("错误了")
		print_stack()
		return null
	if player.当前攻击的随从索引>=player.战斗中的随从.size():
		## 重置
		player.重置攻击随从()
	var temp=player.战斗中的随从.get(player.当前攻击的随从索引) as BaseMinion
	if temp:
		if !temp.是否攻击过:
			if temp.获取带加成属性().x>0:
				return temp
	player.当前攻击的随从索引+=1
	return _获取攻击随从(player)

func _战斗判断():
	if 玩家.战斗中的随从.is_empty() and 敌人.战斗中的随从.is_empty():
		print(玩家)
		print("平局")
		_战斗状态="结束了"
		战斗结束信号.emit(true,null,null)
	elif 玩家.战斗中的随从.is_empty():
		print("玩家胜利")
		_战斗状态="结束了"
		战斗结束信号.emit(false,玩家,敌人)
	elif 敌人.战斗中的随从.is_empty():
		print("敌人胜利")
		_战斗状态="结束了"
		战斗结束信号.emit(false,敌人,玩家)
	else:
		var 玩家攻击力总和=ArrayUtils.sum(玩家.战斗中的随从.map(func(item:BaseMinion): return item.获取带加成属性().x))
		var 敌人攻击力总和=ArrayUtils.sum(敌人.战斗中的随从.map(func(item:BaseMinion): return item.获取带加成属性().x))
		if 玩家攻击力总和==0 and 敌人攻击力总和==0:
			print("平局")
			_战斗状态="结束了"
			战斗结束信号.emit(true,null,null)
			return
		# 继续战斗
		pass

func 获取敌人(player:Player)->Player:
	if player==玩家:
		return 敌人 as Player
	if player==敌人:
		return 玩家 as Player
	printerr("错误了")
	print_stack()
	return null

func _绑定信号(player:Player):
	if !player.添加卡片信号.is_connected(添加卡片.bind(player)):
		player.添加卡片信号.connect(添加卡片.bind(player))
	if !player.删除卡片信号.is_connected(删除卡片.bind(player)):
		player.删除卡片信号.connect(删除卡片.bind(player))

func 开始战斗(player:Player,target:Player):
	self.玩家=player
	self.敌人=target
	_绑定信号(玩家)
	_绑定信号(敌人)
	玩家.战斗初始化(self)
	敌人.战斗初始化(self)
	## ui初始化
	for i in 敌人容器.get_children():
		i.queue_free()
	for i:CardEntity in 敌人.战斗中的随从:
		await 添加卡片(i,Enums.CardPosition.战场,-1,敌人)
	for i in 玩家容器.get_children():
		i.queue_free()
	for i in 玩家.战斗中的随从:
		await 添加卡片(i,Enums.CardPosition.战场,-1,玩家)
	_判断先手()
	# 战斗开始时
	await get_tree().create_timer(1).timeout
	_战斗状态="战斗中"
	pass

func _判断先手():
	# 判断先手
	if 玩家.战场.size()>敌人.战场.size():
		当前攻击者=玩家
	elif 敌人.战场.size()>玩家.战场.size():
		当前攻击者=敌人
	else:
		# 随机
		if randi_range(0,1)==0:
			当前攻击者=玩家
		else:
			当前攻击者=敌人

var 是否正在删除:bool=false
func 删除卡片(
	d:CardEntity,
	cardPosition:Enums.CardPosition,
	player:Player,
):
	是否正在删除=true
	if 是否正在播放动画!=0:
		await get_tree().create_timer(1).timeout
		删除卡片(d,cardPosition,player)
		return
	是否正在删除=false
	if cardPosition==Enums.CardPosition.战场:
		if d.get_parent() is BaseCardUI:
			d.get_parent().queue_free()
	return
	
	
func 添加卡片(
	d:CardEntity,
	cardPosition:Enums.CardPosition,
	index:int,
	player:Player,
):
	if cardPosition!=Enums.CardPosition.战场:
		return
	# 初始ui
	var cardUI
	if d.get_parent() is BaseCardUI:
		cardUI=d.get_parent()
	else:
		cardUI=BaseCardUI.build(d)
	var custom_size=cardUI.custom_minimum_size
	cardUI.custom_minimum_size=Vector2(0,custom_size.y)
	if _是否是敌人(player):
		敌人容器.add_child(cardUI)
		敌人容器.move_child(cardUI,index)
	else:
		玩家容器.add_child(cardUI)
		玩家容器.move_child(cardUI,index)
	await 召唤动画(cardUI,custom_size)
#region 动画方法
## 移动动画
func move_to_target(panel: Node, target: Node, duration: float) -> void:
	var tween = create_tween().set_parallel(true)
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	if panel.global_position.y>target.global_position.y:
		tween.tween_property(panel, "global_position", Vector2(target.global_position.x,target.global_position.y+target.size.y), duration)
	else:
		tween.tween_property(panel, "global_position", Vector2(target.global_position.x,target.global_position.y-target.size.y), duration)
	tween.tween_property(panel, "size", target.size, duration)
	动画播放队列.append(tween)
	await tween.finished

## 溶解动画
func 溶解动画(panel: Node):
	# 1. 创建ShaderMaterial并设置基础参数
	panel.material.set_shader_parameter("progress", 0.0)  # 初始未溶解
	var tween = create_tween()
	tween.tween_property(panel.material, "shader_parameter/progress", 1.0, 2.0)
	#await tween.finished
	动画播放队列.append(tween)
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
	
	动画播放队列.append(tween)
	await tween.finished

## 召唤动画
func 召唤动画(node:Node,custom_minimum_size:Vector2,duration: float=1):
	var tween=create_tween()
	tween.tween_property(node, "custom_minimum_size", custom_minimum_size, duration)
	动画播放队列.append(tween)
	await tween.finished

## 返回原位动画
func return_to_original(panel: Node,original_position,original_size, duration: float) -> void:
	var tween = create_tween().set_parallel(true)
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(panel, "global_position", original_position, duration)
	tween.tween_property(panel, "size", original_size, duration)
	
	动画播放队列.append(tween)
	await tween.finished
	
func start_animation_sequence(panel_a,panel_b):
	var original_position = panel_a.global_position
	var original_size = panel_a.size
	# 1. 移动到目标位置
	await move_to_target(panel_a, panel_b, 0.5)
	# 2. 播放抖动动画
	await shake_panel(panel_b, 0.3, 10.0, 0.8)
	# 3. 返回原位
	await return_to_original(panel_a,original_position,original_size, 0.4)
#endregion
