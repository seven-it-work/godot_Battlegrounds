extends Dead

func 亡语(攻击者:BaseCard,亡语者:BaseCard,player:Player):
	亡语者.neighboring.shuffle()
	for i:BaseCard in 亡语者.neighboring:
		if i.战吼.size()>0:
			for j in i.战吼:
				j.战吼(亡语者,player,null)
			if !亡语者.is_gold:
				return
	pass
