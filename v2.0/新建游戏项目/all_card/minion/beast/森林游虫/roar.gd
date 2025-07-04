extends Roar
func 执行战吼():
	var 属性=执行战吼卡片.get_AttributeBonus()
	属性.atk=1*执行战吼卡片.获取是否为金色的倍率()
	属性.hp=1*执行战吼卡片.获取是否为金色的倍率()
	执行战吼卡片.player.甲虫加成.append(属性)
	pass
