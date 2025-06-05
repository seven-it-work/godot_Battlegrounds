class_name Fight extends Node2D

var player1:Player
var player2:Player



static func build(player1:Player,player2:Player)->Fight:
	var fight=Fight.new()
	fight.player1=player1
	fight.player2=player2
	return fight

func do_fight():
	var attacker:Player
	var defender:Player
	# 判断先手,谁的怪多 谁先手
	if player1.get_minion().size()==player2.get_minion().size():
		if randi_range(0,1)==0:
			attacker=player1
			defender=player2
		else:
			attacker=player2
			defender=player1
	elif player1.get_minion().size()>player2.get_minion().size():
		attacker=player1
		defender=player2
	else:
		attacker=player2
		defender=player1
	# 进入战斗模式
	attacker.start_fight()
	defender.start_fight()
	# 开始战斗计算
	for i in 10:
		# 退出条件1 （任意一方数量为0）
		if attacker.get_minion().size()<=0:
			return {"输家":attacker,"赢家":defender,"是否平局":false}
		if defender.get_minion().size()<=0:
			return {"输家":defender,"赢家":attacker,"是否平局":false}
		# 退出条件2 双方的攻击力总和为0
		var attacker_atk_sum=attacker.get_minion().map(func(card:BaseCard): return card.atk_bonus()).reduce(func(accum, number): return accum + number,0)
		var defender_atk_sum=defender.get_minion().map(func(card:BaseCard): return card.atk_bonus()).reduce(func(accum, number): return accum + number,0)
		if attacker_atk_sum == defender_atk_sum and attacker_atk_sum==0:
			return {"是否平局":true}
		minion_fight(attacker,defender)
		minion_fight(defender,attacker)
	return  {"是否平局":true,"备注":"战斗超时了"}
	pass
	
func minion_fight(attacker:Player,defender:Player):
	# 攻击放随从攻击
	var attacker_minion:BaseCard=attacker.get_minion().front() as BaseCard
	mionion_do_attack(attacker_minion,attacker,defender)
	if attacker_minion.风怒:
		mionion_do_attack(attacker_minion,attacker,defender)
	if attacker_minion.超级风怒:
		mionion_do_attack(attacker_minion,attacker,defender)
		mionion_do_attack(attacker_minion,attacker,defender)
		
func mionion_do_attack(attacker_minion:BaseCard,attacker:Player,defender:Player):
	if attacker_minion.hp_bonus()<=0:
		print("没血了，不能继续攻击了")
		return
	# 目标查询（查询嘲讽）
	var list_嘲讽=defender.get_minion().filter(func(card:BaseCard): return card.嘲讽)
	if list_嘲讽.size()>0:
		# 随机选一个
		var defender_minion:BaseCard=list_嘲讽.pick_random() as BaseCard
		# 攻击方生命值-
		attacker_minion.add_hp(defender_minion,defender_minion.atk_bonus(),attacker)
		# 防御方
		defender_minion.add_hp(attacker_minion,attacker_minion.atk_bonus(),defender)
	# 目标查询（忽略掉潜行的）
	var list_minion=defender.get_minion().filter(func(card:BaseCard): return !card.潜行)
	if list_minion.size()>0:
		# 随机选一个
		var defender_minion:BaseCard=list_minion.pick_random() as BaseCard
		# 攻击方生命值-
		attacker_minion.add_hp(defender_minion,-defender_minion.atk_bonus(),attacker)
		# 防御方
		defender_minion.add_hp(attacker_minion,-attacker_minion.atk_bonus(),defender)
