extends BeastCard




func 触发器_受伤(atkker:BaseCard,num:int,player:Player):
	var card=preload("uid://ccubfqusy04hi").instantiate()
	card.嘲讽=true
	card.atk=2;
	card.hp=2;
	player.add_card_in_bord(card)
	pass
