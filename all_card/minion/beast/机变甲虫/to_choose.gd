extends ToChoose

# <b>抉择：</b>使一只野兽获得+1/+1和<b>复生</b>；或者+8攻击力。
func select_1(trigger:BaseCard,target_list:Array[BaseCard],player:Player):
	# target 复生 +1/+1
	var card:BaseCard=target_list.get(0)
	card.复生=true
	card.add_atk(trigger,1*2 if trigger.is_gold else 1,player)
	card.add_hp(trigger,1*2 if trigger.is_gold else 1,player)
	pass
	
func select_2(trigger:BaseCard,target_list:Array,player:Player):
	# target 嘲讽 +3/+3
	var card:BaseCard=target_list.get(0)
	#card.嘲讽=true
	card.add_atk(trigger,8*2 if trigger.is_gold else 1,player)
	#card.add_hp(trigger,3,player)
	pass
