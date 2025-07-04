extends CardData

func 使用触发():
	super.使用触发(player)
	player.刷新酒馆([
		CardFindCondition.build("lv",5,CardFindCondition.ConditionEnum.等于)
	])
