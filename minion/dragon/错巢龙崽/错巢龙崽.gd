extends BaseCard

func 触发器_战斗开始时(player:Player):
	add_atk(self,player.tavern.lv*2 if is_gold else player.tavern.lv,player)
	add_hp(self,player.tavern.lv*2 if is_gold else player.tavern.lv,player)
	pass
