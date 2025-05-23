extends Dead

func do_action(triggere:BaseCard,player:Player):
	print("todo 添加豹宝宝")
	for i in 2:
		var data=preload("uid://ctbny8037yk73").instantiate()
		player.add_card_in_bord(data)
	pass
