extends Dead

func 执行亡语(攻击者:CardData):
	var 邻居=亡语者.邻居
	var 执行list=[]
	if 亡语者.is_gold:
		for i:CardData in 邻居:
			if i.是否有战吼():
				执行list.append(i)
	else:
		执行list.append(邻居.pick_random())
	for i:CardData in 执行list:
		i.获取战吼节点().执行战吼()
