extends TargetSelector

func 筛选方法(list:Array)->Array:
	return list.filter(func(card:DragControl): return card.card_data.lv<=4 and card.card_data.所在位置==Enums.CardPosition.战场)
