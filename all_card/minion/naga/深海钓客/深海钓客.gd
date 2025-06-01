extends BaseCard

func 触发器_回合开始时(player:Player):
	var card=preload("uid://dnwvw7b87v8eu").instantiate()
	card.is_gold=is_gold
	player.add_card_in_bord(card)
	pass
