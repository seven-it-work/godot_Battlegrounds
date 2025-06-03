extends Dead

func 亡语(攻击者:BaseCard,亡语者:BaseCard,player:Player):
	for i in 2 if 亡语者.is_gold else 1:
		player.add_card_in_handler(preload("uid://dxxgwlqr5y8nt").instantiate()) 
	pass
