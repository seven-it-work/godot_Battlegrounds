extends Dead

func 亡语(攻击者:CardData,player:Player):
	var card=preload("uid://clurlnso3urhr").instantiate()
	card.atk=player.甲虫.x
	card.hp=player.甲虫.y
	player.add_card_in_bord(card)
	pass
