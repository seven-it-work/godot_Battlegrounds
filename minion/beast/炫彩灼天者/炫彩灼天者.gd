extends BeastCard

func add_card_in_bord_end(player:Player):
	player.受伤触发信号.connect(受伤触发器)
	pass

func 受伤触发器(受伤card:BaseCard,攻击card:BaseCard,num:int,player:Player):
	var list=player.get_minion()
	# 过滤野兽
	
	# 过滤非受伤的随从
	list=list.filter(func(card): return card.uuid!=受伤card.uuid)
	if list.size()<=0:
		return
	var data = list.pick_random()
	var call_func = func (findCard:BaseCard,player:Player):
		findCard.add_atk(self,1,player)
		findCard.add_hp(self,2,player)
	player.minion_property_func(data,call_func.bind(player),true)
	pass
