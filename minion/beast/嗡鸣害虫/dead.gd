extends Dead


func do_action(trigger:BaseCard,player:Player):
	var temp=preload("uid://c7hlohbk4aa8t").instantiate()
	temp.hp=2
	temp.atk=2
	player.add_card_in_bord(temp)
	pass
