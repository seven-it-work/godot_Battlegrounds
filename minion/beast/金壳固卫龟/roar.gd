extends Roar


func do_action(trigger:BaseCard,player:Player):
	# todo 过滤野兽类型
	var beast_list=player.get_minion()
	for i in beast_list:
		i.add_atk(trigger,2,player)
		i.add_hp(trigger,4,player)
	pass
