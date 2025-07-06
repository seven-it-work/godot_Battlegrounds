extends CardData

func 使用触发():
	super.使用触发()
	var allied_minions=player.战场.获取所有节点()
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	for minion in allied_minions:
		var 属性=get_AttributeBonus()
		属性.atk=4+合计加成.atk
		属性.hp=4+合计加成.atk
		minion.cardData.属性添加(self,属性)
