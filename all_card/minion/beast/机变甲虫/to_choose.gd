extends ToChoose

func select_1(trigger:BaseCard,target_list:Array[BaseCard],player:Player):
	# target 复生 +1/+1
	var card:BaseCard=target_list.get(0)
	card.复生=true
	card.add_atk(trigger,1,player)
	card.add_hp(trigger,1,player)
	pass
	
func select_2(trigger:BaseCard,target_list:Array,player:Player):
	# target 嘲讽 +3/+3
	var card:BaseCard=target_list.get(0)
	card.嘲讽=true
	card.add_atk(trigger,3,player)
	card.add_hp(trigger,3,player)
	pass
