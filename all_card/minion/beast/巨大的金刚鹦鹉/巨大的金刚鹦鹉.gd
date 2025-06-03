
extends BaseCard
#在本随从攻击后，触发你最左边的<b>亡语</b><i>（本随从的除外）</i>。
func 触发器_攻击后(player:Player,攻击目标:BaseCard):
	super.触发器_攻击后(player,攻击目标)
	var list=player.get_minion().filter(func(card:BaseCard): return card.是否存在亡语())
	if list.size()<=0:
		return
	var front=list.front()
	front.触发器_亡语(null,player)
	pass
	
