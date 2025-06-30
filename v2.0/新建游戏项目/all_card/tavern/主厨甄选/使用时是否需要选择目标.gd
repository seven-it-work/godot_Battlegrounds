extends TargetSelector

func 筛选方法(list:Array[DragControl])->Array:
	return list.filter(func(card:DragControl): return !card.card_data.是否属于种族(Enums.RaceEnum.NONE))
