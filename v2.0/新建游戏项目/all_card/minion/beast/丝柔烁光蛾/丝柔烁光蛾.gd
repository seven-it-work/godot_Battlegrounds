extends CardData

func 触发器_获得攻击力(触发者:CardData,num:int):
	super.触发器_获得攻击力(触发者,num)
	var 属性=get_AttributeBonus()
	属性.atk=2*(2 if is_gold else 1)
	属性.hp=2*(2 if is_gold else 1)
	player.甲虫加成.append(属性)
	pass
