extends Dead
#<b>嘲讽</b>。<b>亡语：</b>使你最右边的野兽永久获得+5/+5。

func 亡语(攻击者:BaseCard,亡语者:BaseCard,player:Player):
	var list=player.get_minion().filter(func(card:BaseCard): return card.race.has(BaseCard.RaceEnum.BEAST))
	if list.size()<=0:
		return
	var back=list.back()
	player.minion_property_func(back,func(find_card:BaseCard):
		find_card.add_atk(亡语者,10 if 亡语者.is_gold else 5,player)
		find_card.add_hp(亡语者,10 if 亡语者.is_gold else 5,player)
	,true)
	pass
