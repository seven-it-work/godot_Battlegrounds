extends BaseCard

func 触发器_出售(player:Player):
	super.触发器_出售(player)
	for i in 4 if is_gold else 2:
		player.add_card_in_handler(preload("uid://c84v1i3ulob37").instantiate())
	pass
