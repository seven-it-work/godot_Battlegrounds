extends Dead


func 亡语(攻击者:BaseCard,亡语者:BaseCard,player:Player):
	for i in 2 if 亡语者.is_gold else 1:
		var temp=preload("uid://c7hlohbk4aa8t").instantiate()
		temp.hp=player.甲虫.x
		temp.atk=player.甲虫.y
		player.add_card_in_bord(temp)
	pass
