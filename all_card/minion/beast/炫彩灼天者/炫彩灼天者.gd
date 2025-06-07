extends BaseCard



func 触发器_他人受伤(atkker:BaseCard,injurie_card:BaseCard,num:int,player:Player):
	var list=player.get_minion()
	# 过滤野兽
	
	# 过滤非受伤的随从
	list=list.filter(func(card): return card.uuid!=injurie_card.uuid)
	if list.size()<=0:
		return
	var data = list.pick_random()
	data.add_atk(self,1,player,true)
	data.add_hp(self,2,player,true)
	pass
