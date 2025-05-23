extends Roar

func do_action(triggere:BaseCard,player:Player):
	player.add_card_in_bord(preload("uid://ccbl6jks6vaxj").instantiate())
