extends CardData

func 使用触发(player:Player):
	super.使用触发(player)
	var allied_minions=player.战场.获取所有节点(true)
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	for minion in allied_minions:
		minion.card_data.atk_process(minion,4+合计加成.atk,player)
		minion.card_data.hp_process(minion,4+合计加成.hp,player)
