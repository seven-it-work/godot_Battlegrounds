
extends BaseCard

func 手牌触发器_战斗开始时(player:Player):
	super.手牌触发器_战斗开始时(player)
	var list=player.get_minion().filter(func(card:BaseCard): return card.是否存在亡语())
	for i in 2 if is_gold else 1:
		var index=0
		for j:BaseCard in list:
			if index>2:
				break
			index+=1
			j.触发器_亡语(null,player)
	pass
	
