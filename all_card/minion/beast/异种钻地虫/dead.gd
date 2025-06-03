extends Dead
#<b>亡语：</b>使你的野兽获得+{0}/+{0}。<b>复仇（1）：</b>此效果永久提升+1/+1。

func 亡语(攻击者:BaseCard,亡语者:BaseCard,player:Player):
	var list=player.get_minion().filter(func(card:BaseCard): return card.race.has(BaseCard.RaceEnum.BEAST))
	for i:BaseCard in list:
		i.add_atk(亡语者,亡语者.效果.x,player)
		i.add_hp(亡语者,亡语者.效果.y,player)
	pass
