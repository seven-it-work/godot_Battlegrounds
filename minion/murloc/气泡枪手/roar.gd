extends Roar

func 战吼(触发者:BaseCard,player:Player,目标对象:BaseCard):
	var pick_list=[]
	for i in 触发者.额外属性:
		if !触发者[i]:
			pick_list.append(i)
	if pick_list.size()<=0:
		return
	pick_list.shuffle()
	for i in 2 if 触发者.is_gold else 1:
		var key=pick_list.pop_back()
		if key:
			触发者[key]=true
	pass
