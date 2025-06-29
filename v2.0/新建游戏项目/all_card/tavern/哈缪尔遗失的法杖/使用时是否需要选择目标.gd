extends TargetSelector

func 筛选方法(list:Array)->Array:
	return list.filter(func(card:CardData): return !card.card_data.是否属于种族(Enums.RaceEnum.NONE))
