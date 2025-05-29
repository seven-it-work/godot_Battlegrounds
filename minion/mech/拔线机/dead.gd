extends Dead
func 亡语(攻击者:BaseCard,亡语者:BaseCard,player:Player):
	var card=preload("uid://cc7eg8828sbjy").instantiate()
	card.is_gold=亡语者.is_gold
	player.add_card_in_bord(card)
	pass
