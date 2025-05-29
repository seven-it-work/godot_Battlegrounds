extends BeastCard


func 触发器_他人受伤(atkker:BaseCard,injurie_card:BaseCard,num:int,player:Player):
	var call_func = func (findCard:BaseCard,player:Player):
		findCard.add_hp(findCard,1,player)
		findCard.add_atk(findCard,1,player)
	player.minion_property_func(self,call_func.bind(player),true)
	pass
