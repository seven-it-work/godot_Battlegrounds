extends VBoxContainer
class_name FightUI

var 敌人:Dictionary
var 玩家:Dictionary

func _ready() -> void:
	# 随机一个子文件
	pass

func 刷新(player:Player):
	if player==敌人.player:
		for i in $"敌人".get_children():
			i.free()
		for i in 敌人.player.战斗中的牌:
			var node=preload("uid://dl0ad8ft57aqx").instantiate()
			node.initData(i)
			node.位置=CardUi.PositionEnum.战场
			$"敌人".add_child(node)
		self.敌人={player=player,随从ui=$"敌人"}
		return
	
	if player==玩家.player:
		for i in $"玩家".get_children():
			i.free()
		for i in 玩家.player.战斗中的牌:
			var node=preload("uid://dl0ad8ft57aqx").instantiate()
			node.initData(i)
			node.位置=CardUi.PositionEnum.战场
			$"玩家".add_child(node)
		self.玩家={player=player,随从ui=$"玩家"}
	pass

func init(player:Player,target:Player):
	self.玩家={player=player,随从ui=$"玩家"}
	self.敌人={player=target,随从ui=$"敌人"}
	# ui初始化
	for i in $"敌人".get_children():
		i.free()
	for i in $"玩家".get_children():
		i.free()
	self.玩家.player.start_fight(self)
	self.敌人.player.start_fight(self)
	for i in 玩家.player.战斗中的牌:
		var node=preload("uid://dl0ad8ft57aqx").instantiate()
		node.initData(i)
		node.位置=CardUi.PositionEnum.战场
		$"玩家".add_child(node)
	for i in 敌人.player.战斗中的牌:
		var node=preload("uid://dl0ad8ft57aqx").instantiate()
		node.initData(i)
		node.位置=CardUi.PositionEnum.战场
		$"敌人".add_child(node)
	await get_tree().create_timer(1.0).timeout
	var result=await do_fight()
	print(result)
	Globals.main_node.get_node("PanelContainer/战斗ui/操作/PanelContainer/VBoxContainer/结束战斗").visible=true
	pass



func do_fight():
	var attacker:Dictionary
	var defender:Dictionary
	# 判断先手,谁的怪多 谁先手
	if 玩家.player.get_minion().size()==敌人.player.get_minion().size():
		if randi_range(0,1)==0:
			attacker=玩家
			defender=敌人
		else:
			attacker=敌人
			defender=玩家
	elif 玩家.player.get_minion().size()>敌人.player.get_minion().size():
		attacker=玩家
		defender=敌人
	else:
		attacker=敌人
		defender=玩家
	# 进入战斗模式
	attacker.player.战斗开始时()
	defender.player.战斗开始时()
	# 开始战斗计算
	for i in 100:
		# 都没有随从平局
		if attacker.随从ui.get_children().size()<=0 and defender.随从ui.get_children().size()<=0:
			return {"是否平局":true}
		# 退出条件1 （任意一方数量为0）
		if attacker.随从ui.get_children().size()<=0:
			return {"输家":attacker,"赢家":defender,"是否平局":false}
		if defender.随从ui.get_children().size()<=0:
			return {"输家":defender,"赢家":attacker,"是否平局":false}
		# 退出条件2 双方的攻击力总和为0
		var attacker_atk_sum=attacker.随从ui.get_children().map(func(cardUi:CardUi): return cardUi.card.atk_bonus(attacker.player)).reduce(func(accum, number): return accum + number,0)
		var defender_atk_sum=defender.随从ui.get_children().map(func(cardUi:CardUi): return cardUi.card.atk_bonus(defender.player)).reduce(func(accum, number): return accum + number,0)
		if attacker_atk_sum == defender_atk_sum and attacker_atk_sum==0:
			return {"是否平局":true}
		await minion_fight(attacker,defender)
		await minion_fight(defender,attacker)
	return  {"是否平局":true,"备注":"战斗超时了"}
	pass
	
func minion_fight(attacker:Dictionary,defender:Dictionary):
	if attacker.随从ui.get_children().size()<=0:
		return
	# 攻击放随从攻击
	var attacker_minion:CardUi=attacker.随从ui.get_children().front() as CardUi
	if is_instance_valid(attacker_minion):
		await mionion_do_attack(attacker_minion,attacker,defender)
	if is_instance_valid(attacker_minion) and  attacker_minion.card.风怒:
		await mionion_do_attack(attacker_minion,attacker,defender)
	if  is_instance_valid(attacker_minion) and  attacker_minion.card.超级风怒:
		await mionion_do_attack(attacker_minion,attacker,defender)
		await mionion_do_attack(attacker_minion,attacker,defender)

func mionion_do_attack(attacker_minion:CardUi,attacker:Dictionary,defender:Dictionary):
	if attacker_minion.card.hp_bonus(attacker.player)<=0:
		print("没血了，不能继续攻击了")
		return
	if attacker_minion.card.atk_bonus(attacker.player)<=0:
		return
	# 目标查询（查询嘲讽）
	var list_嘲讽=defender.随从ui.get_children().filter(func(cardUi:CardUi): return cardUi.card.嘲讽)
	if list_嘲讽.size()>0:
		# 随机选一个
		var defender_minion:CardUi=list_嘲讽.pick_random() as CardUi
		await 生命计算(attacker,attacker_minion,defender,defender_minion)
		return
	# 目标查询（忽略掉潜行的）
	var list_minion=defender.随从ui.get_children().filter(func(cardUi:CardUi): return !cardUi.card.潜行)
	if list_minion.size()>0:
		# 随机选一个
		var defender_minion:CardUi=list_minion.pick_random() as CardUi
		await 生命计算(attacker,attacker_minion,defender,defender_minion)


func 生命计算(attacker:Dictionary,attacker_minion:CardUi,defender:Dictionary,defender_minion:CardUi):
	print("%s的%s对%s的%s进行攻击"%[attacker.player.name_str,attacker_minion.card.name_str,defender.player.name_str,defender_minion.card.name_str])
	await  start_animation_sequence(attacker_minion,defender_minion)
	# 攻击方生命值
	var attacker_card=attacker_minion.card
	var defender_card=defender_minion.card
	
	attacker_card.add_hp(defender_card,-defender_card.atk_bonus(attacker.player),attacker.player)
	# 防御方
	defender_card.add_hp(attacker_card,-attacker_card.atk_bonus(defender.player),defender.player)
	
	if attacker_card.是否死亡(attacker.player):
		print("%s死亡，进行移除"%attacker_card.name_str)
		刷新(attacker.player)
		
	if defender_card.是否死亡(defender.player):
		print("%s死亡，进行移除"%defender_card.name_str)
		刷新(defender.player)
	pass


func move_panel_to_panel(a: PanelContainer, b: PanelContainer, duration: float = 0.5) -> void:
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

func start_animation_sequence(panel_a,panel_b):
	var  original_position = panel_a.global_position
	var original_size = panel_a.size
	# 1. 移动到目标位置
	await move_to_target(panel_a, panel_b, 0.5)
	
	# 2. 播放抖动动画
	await shake_panel(panel_b, 0.3, 10.0, 0.8)
	
	# 3. 返回原位
	await return_to_original(panel_a,original_position,original_size, 0.4)

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


func _on_button_pressed() -> void:
	var filelist=FileUtis.get_all_files_in_directory("res://fight_ai/1")
	init(FileAccess.open(filelist.pick_random(),FileAccess.READ).get_var(true),FileAccess.open(filelist.pick_random(),FileAccess.READ).get_var(true))
	pass # Replace with function body.
