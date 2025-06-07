extends Dead
func 亡语(攻击者:BaseCard,亡语者:BaseCard,player:Player):
	var card=player.get_minion().pick_random()
	if card==null:
		return
	card.add_hp(亡语者,亡语者.hp_bonus(player)-亡语者.受伤记录,player)
	pass
