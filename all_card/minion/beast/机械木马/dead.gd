extends Dead


func 亡语(攻击者:BaseCard,亡语者:BaseCard,player:Player):
	for i in 2:
		var data=preload("uid://dv2b8dmpsmbau").instantiate()
		data.hp=2;
		data.atk=2
		player.add_card_in_bord(data)
	pass
