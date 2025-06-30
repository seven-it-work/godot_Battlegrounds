extends CardData

func 是否能够使用(player:Player)->bool:
	var 所有list=player.获取战场和酒馆中的牌().filter(func(card:DragControl): return !card.card_data.是否属于种族(Enums.RaceEnum.NONE))
	return !所有list.is_empty()

func 使用触发(player:Player):
	print("使用",name_str)
	if $"使用时是否需要选择目标".目标对象==null:
		# 随机选择目标（战场和酒馆）
		var 所有list=player.获取战场和酒馆中的牌().filter(func(card:CardData): return !card.card_data.是否属于种族(Enums.RaceEnum.NONE))
		if 所有list.is_empty():
			Logger.debug("没有任何型，无法中")
			return
		else:
			$"使用时是否需要选择目标".目标对象=所有list.pick_random()
	# 如果目标存在类型
	var cardData= $"使用时是否需要选择目标".目标对象.card_data as CardData
	if cardData.race.has(Enums.RaceEnum.NONE):
		Logger.error("错误获取类型，不能获取空类型")
		return
	var type=cardData.race.pick_random()
	var 随从型件=CardFindCondition.build(
			"race",type,CardFindCondition.ConditionEnum.在
		)
	var 随从list=CardsUtils.find_card([
		随从型件,
		CardsUtils.COMMON_CODITION.出现在酒馆,
		CardsUtils.COMMON_CODITION.随从,
		CardsUtils.COMMON_CODITION.低于当前等级(player),
	])
	var 选择的从随=随从list.pick_random()
	# 选择一个随从。获取相同类型的另一张随从牌。
	player.添加到手牌(选择的从随)
	pass
