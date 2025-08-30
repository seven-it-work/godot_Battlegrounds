extends SelectTarget

func 获取选择的目标对象(list:Array):
	return super.获取选择的目标对象(list)\
		.filter(func(item:BaseMinion): return item.race.has(Enums.CardRace.鱼人))
