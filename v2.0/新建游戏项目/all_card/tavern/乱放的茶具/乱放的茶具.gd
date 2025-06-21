extends CardData

func 使用触发(player:Player):
	# 获取player 战场中的所有随从
	# 按照随从的种族
	if $"使用时是否需要选择目标".目标对象:
		print("todo 待开发主厨甄选或者种族类型相同的随从",$"使用时是否需要选择目标".目标对象.card_data.race)
	pass


func buff_one_of_each_type(player:Player) -> void:
	var allied_minions=player.战场.获取所有节点(true)
	var buffed_types = {}  # 已buff的类型
	var minions_sorted = []  # 按类型数量排序后的随从
	# 1. 过滤掉无类型随从，并按类型数量从少到多排序
	minions_sorted = allied_minions.filter(
		func(card:DragControl): return !card.card_data.是否属于种族(Enums.RaceEnum.NONE)
	)
	minions_sorted.sort_custom(
		func(a:DragControl, b:DragControl): return a.card_data.race.size() < b.card_data.race.size()
	)
	
	# 2. 按顺序处理（类型少的优先）
	for minion in minions_sorted:
		var unbuffed_types = minion.types.filter(
			func(t): return not buffed_types.has(t)
		)
		if unbuffed_types.size() > 0:
			# todo 这里是加成方法
			加成方法()
			buffed_types[unbuffed_types[0]] = true  # 只标记第一个可用类型
			# 提前终止：所有类型都已覆盖
			if buffed_types.size() == Enums.RaceEnum.size() - 1:
				break

func 加成方法():
	print("加成方法")
	pass
