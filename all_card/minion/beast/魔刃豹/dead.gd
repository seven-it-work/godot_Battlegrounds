extends Dead

func 亡语(攻击者:BaseCard,亡语者:BaseCard,player:Player):
	for i in 2:
		var data=preload("uid://bwy107nkxg0v2").instantiate()
		data.is_gold=亡语者.is_gold
		player.add_card_in_bord(data)
	pass
