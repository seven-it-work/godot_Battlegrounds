extends CardData

func 使用触发(player:Player):
	CardsUtils.find_card([
		CardsUtils.COMMON_CODITION.随从,
		CardsUtils.COMMON_CODITION.出现在酒馆,
		CardFindCondition.build("lv",1,CardFindCondition.ConditionEnum.等于),
	])
