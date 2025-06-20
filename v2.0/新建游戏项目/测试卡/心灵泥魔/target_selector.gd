extends TargetSelector

func 筛选方法(list:Array)->Array:
	print("xinlem 筛选方法")
	return list.filter(func(card:DragControl): 
		return card.card_data.是否属于种族(Enums.RaceEnum.DEMON) and card.card_data.所在位置==Enums.CardPosition.战场
		)
