extends Roar


func 战吼(触发者:BaseCard,player:Player,目标对象:BaseCard):
	# todo 过滤野兽类型
	var beast_list=player.get_minion()
	for i in beast_list:
		i.add_atk(触发者,2,player)
		i.add_hp(触发者,4,player)
	pass
