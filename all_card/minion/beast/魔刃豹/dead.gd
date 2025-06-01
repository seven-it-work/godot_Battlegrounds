extends Dead

func 亡语(攻击者:BaseCard,亡语者:BaseCard,player:Player):
	for i in 2:
		var data=preload("uid://ctbny8037yk73").instantiate()
		data.is_gold=亡语者.is_gold
		player.add_card_in_bord(data)
	pass
