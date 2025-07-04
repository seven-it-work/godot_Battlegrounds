extends CardData


func 触发器_战斗开始时(player:Player):
	if player.是否在战斗中():
		var 属性=get_AttributeBonus()
		属性.atk=1;
		player.野兽加成.append(属性)
		player.fight.战斗结束后调用的方法合集.append(func(): 
			player.野兽加成.erase(属性)
		)
	pass
