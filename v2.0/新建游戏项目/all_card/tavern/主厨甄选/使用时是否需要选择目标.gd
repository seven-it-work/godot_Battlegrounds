extends TargetSelector

func 筛选方法(list:Array[CardUI])->Array[CardUI]:
	return list.filter(func(card:Card): return  !card.card_data.是否为法术() and !card.card_data.是否属于种族(Enums.RaceEnum.NONE))
