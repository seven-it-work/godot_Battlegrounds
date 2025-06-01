extends Dead

func 亡语(攻击者:BaseCard,亡语者:BaseCard,player:Player):
	var chu_shou=preload("uid://c3wyvl514n2ah").instantiate()
	chu_shou.hp=亡语者.chu_shou_hp
	chu_shou.atk=亡语者.chu_shou_atk
	player.add_card_in_bord(chu_shou)
	pass
