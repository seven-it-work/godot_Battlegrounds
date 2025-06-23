extends CardData


func 使用触发(player:Player):
	if $"使用时是否需要选择目标".目标对象:
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
