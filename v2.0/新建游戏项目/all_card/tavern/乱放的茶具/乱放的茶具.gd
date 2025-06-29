extends CardData

func 使用触发(player:Player):
	buff_one_of_each_type(player)

func get_desc(player:Player,otherJson:Dictionary={})->String:
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	otherJson.set("法术攻击值",3+合计加成.atk)
	otherJson.set("法术生命值",3+合计加成.hp)
	return super.get_desc(player,otherJson)

func buff_one_of_each_type(player:Player) -> void:
	var allied_minions=player.战场.获取所有节点(true)
	var buffed_types = {}  # 已buff的类型
	var minions_sorted = []  # 按类型数量排序后的随从
	# 1. 过滤掉无类型随从，并按类型数量从少到多排序
	minions_sorted = allied_minions.filter(
		func(card:CardData): return !card.card_data.是否属于种族(Enums.RaceEnum.NONE)
	)
	minions_sorted.sort_custom(
		func(a:CardData, b:CardData): return a.card_data.race.size() < b.card_data.race.size()
	)
	
	# 2. 按顺序处理（类型少的优先）
	for minion in minions_sorted:
		var unbuffed_types = minion.types.filter(
			func(t): return not buffed_types.has(t)
		)
		if unbuffed_types.size() > 0:
			加成方法(minion,player)
			buffed_types[unbuffed_types[0]] = true  # 只标记第一个可用类型
			# 提前终止：所有类型都已覆盖
			if buffed_types.size() == Enums.RaceEnum.size() - 1:
				break

func 加成方法(minion:CardData,player:Player):
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	minion.card_data.atk_process(minion,3+合计加成.atk,player)
	minion.card_data.hp_process(minion,3+合计加成.hp,player)
	pass
