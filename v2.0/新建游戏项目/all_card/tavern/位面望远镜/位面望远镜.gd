extends CardData

func 使用触发(player:Player):
	var 战场上的牌=player.战场.获取所有节点().filter(func(card:DragControl): return !card.card_data.是否属于种族(Enums.RaceEnum.NONE))
	if 战场上的牌.is_empty():
		return
	# 整理出来，让种族最多的进行选择
	var 种族数量:Dictionary={}
	for i:DragControl in 战场上的牌:
		for j in i.card_data.race:
			var count=种族数量.get_or_add(j,0)
			种族数量.set(j,count+1)
	var maxRace:Array=[]
	var maxCount:int=0;
	for key in 种族数量:
		if 种族数量[key]>maxCount:
			maxRace.clear()
			maxCount=种族数量[key]
			maxRace.append(key)
		elif 种族数量[key]==maxCount:
			maxRace.append(key)
		else:
			pass
	var 最多的种族=maxRace.pick_random()
	
	var 随从型件=CardFindCondition.build(
		"race",最多的种族,CardFindCondition.ConditionEnum.在
	)
	var 随从list=CardsUtils.find_card([
		随从型件,
		CardsUtils.COMMON_CODITION.出现在酒馆,
		CardsUtils.COMMON_CODITION.随从,
		CardsUtils.COMMON_CODITION.低于当前等级(player),
	])
	if 随从list.is_empty():
		Logger.error("没有随从可以选择了",name_str)
		return
	var 选择的从随=随从list.pick_random()
	# 选择一个随从。获取相同类型的另一张随从牌。
	player.添加到手牌(选择的从随)
	pass
