extends BaseCard

func 触发器_获得攻击力(触发者:BaseCard,num:int,player:Player):
	super.触发器_获得攻击力(触发者,num,player)
	add_hp(触发者,2 if is_gold else 1,player)
	pass
