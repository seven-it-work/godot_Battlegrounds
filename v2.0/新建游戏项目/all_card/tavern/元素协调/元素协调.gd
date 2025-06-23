extends CardData


func 使用触发(player:Player):
	super.使用触发(player)
	var 属性=self.get_AttributeBonus()
	属性.atk=3
	属性.hp=3
	player.元素酒馆加成.append(属性)
	pass
