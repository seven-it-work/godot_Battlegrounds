extends Dead

func do_action(trigger:BaseCard,player:Player):
	for i in 2:
		var data=preload("uid://bjogxoyie5ama").instantiate()
		data.hp=1;
		data.atk=1;
		player.add_card_in_bord(data)
	pass
