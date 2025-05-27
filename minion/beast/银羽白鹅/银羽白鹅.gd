extends BeastCard


func add_card_in_bord_end(player:Player):
	player.受伤触发信号.connect(受伤触发器)
	pass

func 受伤触发器(受伤card:BaseCard,攻击card:BaseCard,num:int,player:Player):
	var card=preload("uid://ccubfqusy04hi").instantiate()
	card.嘲讽=true
	card.atk=2;
	card.hp=2;
	player.add_card_in_bord(card)
	pass
