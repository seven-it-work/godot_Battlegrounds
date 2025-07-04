extends CardData

func 触发器_复仇():
	var 属性=get_AttributeBonus()
	属性.atk=2*获取是否为金色的倍率()
	属性.hp=2*获取是否为金色的倍率()
	player.甲虫加成.append(属性)
