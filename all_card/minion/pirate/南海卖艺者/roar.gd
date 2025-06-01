extends Roar


func 战吼(触发者:BaseCard,player:Player,目标对象:BaseCard):
	var f=func(player:Player):
		player.tavern.current_coin+=2 if 触发者.is_gold else 1
	player.回合开始时回调的方法.append(f.bind(player))
	pass
