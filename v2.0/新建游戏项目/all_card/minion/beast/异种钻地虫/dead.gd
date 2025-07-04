extends Dead

func 亡语(攻击者:CardData,player:Player):
	var list=player.获取战场中的牌()
	for i:CardData in list:
		if i.是否属于种族(Enums.RaceEnum.BEAST):
			var 属性=亡语者.get_AttributeBonus()
			属性.atk=亡语者.temp_atk
			属性.hp=亡语者.temp_hp
			i.属性添加(亡语者,属性)
