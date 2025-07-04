extends CardData

func 触发器_召唤其他随从(其他随从:CardData):
	if player.是否在战斗中():
		if 其他随从.是否属于种族(Enums.RaceEnum.BEAST):
			var list=player.获取战场中的牌().filter(func(card:CardData): return card.是否属于种族(Enums.RaceEnum.BEAST))
			var 目标随从=list.back() as CardData
			var 属性=get_AttributeBonus()
			属性.atk=3*获取是否为金色的倍率()
			属性.hp=3*获取是否为金色的倍率()
			目标随从.属性添加(self,属性,true)
	pass
