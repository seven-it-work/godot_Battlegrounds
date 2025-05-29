extends BaseCard
func 触发器_回合结束时(player:Player):
	self.add_hp(self,2 if is_gold else 1,player)
	pass
