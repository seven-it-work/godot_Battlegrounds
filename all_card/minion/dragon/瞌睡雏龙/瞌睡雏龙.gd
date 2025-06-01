extends BaseCard

func 触发器_受伤(atkker:BaseCard,num:int,player:Player):
	var f=func(find_card):
		find_card.add_atk(self,2 if is_gold else 1,player)
		pass
	player.minion_property_func(self,f,true)
	pass
