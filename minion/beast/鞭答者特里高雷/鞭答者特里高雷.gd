extends BeastCard


func add_card_in_bord_end(player:Player):
	player.受伤触发信号.connect(受伤触发器)
	pass

func 受伤触发器(受伤card:BaseCard,攻击card:BaseCard,num:int,player:Player):
	# 如果是自己则return
	if 受伤card.uuid==self.uuid:
		return
	var call_func = func (findCard:BaseCard,player:Player):
		findCard.add_hp(findCard,1,player)
		findCard.add_atk(findCard,1,player)
	player.minion_property_func(self,call_func.bind(player),true)
	pass
