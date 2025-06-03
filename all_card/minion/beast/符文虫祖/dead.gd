extends Dead

func 亡语(攻击者:BaseCard,亡语者:BaseCard,player:Player):
	player.甲虫+=Vector2(1,2)*2 if 亡语者.is_gold else 1
	for i in 2 if 亡语者.is_gold else 1:
		var card=preload("uid://djkff67opsi1v").instantiate()
		card.atk=player.甲虫.x
		card.hp=player.甲虫.y
		player.add_card_in_bord(card)
	pass
