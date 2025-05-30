extends BaseCard

func 触发器_出售(player:Player):
	for i in 2 if is_gold else 1:
		var card=preload("uid://dpdldlr3075f7").instantiate()
		card.atk=3
		card.hp=3
		player.add_card_in_handler(card)
	pass
