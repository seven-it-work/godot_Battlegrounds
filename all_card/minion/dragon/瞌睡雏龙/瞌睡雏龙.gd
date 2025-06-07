extends BaseCard

func 触发器_受伤(atkker:BaseCard,num:int,player:Player):
	self.add_atk(self,2 if is_gold else 1,player,true)
	pass
