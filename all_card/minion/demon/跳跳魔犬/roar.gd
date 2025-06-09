extends Roar
func 战吼(触发者:BaseCard,player:Player,目标对象:BaseCard):
	player.tavern.刷新({
		消耗生命值法术=2 if 触发者.is_gold else 1
	})
	player.酒馆的牌变化=true
	pass
