extends Dead

func do_action(trigger:BaseCard,player:Player):
	for i:BaseCard in trigger.neighboring:
		if i.战吼.size()>0:
			for j in i.战吼:
				j.do_action(i,player)
	pass
