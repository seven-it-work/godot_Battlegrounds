extends Dead

func do_action(trigger:BaseCard,player:Player):
	var chu_shou=preload("uid://c3wyvl514n2ah").instantiate()
	chu_shou.hp=trigger.chu_shou_hp
	chu_shou.atk=trigger.chu_shou_atk
	player.add_card_in_bord(chu_shou)
	pass
