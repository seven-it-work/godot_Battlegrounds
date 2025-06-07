extends BaseCard


func 触发器_他人受伤(atkker:BaseCard,injurie_card:BaseCard,num:int,player:Player):
	self.add_hp(self,1,player,true)
	self.add_atk(self,1,player,true)
	pass
