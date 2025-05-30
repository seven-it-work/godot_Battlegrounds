extends Dead
func 亡语(攻击者:BaseCard,亡语者:BaseCard,player:Player):
	var card=player.get_minion().pick_random()
	if card==null:
		return
	var f=func(find_card:BaseCard):
		find_card.add_hp(亡语者,亡语者.hp_bonus()-亡语者.受伤记录,player)
	player.minion_property_func(card,f)
	pass
