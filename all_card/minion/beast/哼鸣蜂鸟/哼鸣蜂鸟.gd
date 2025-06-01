extends BaseCard

func 触发器_战斗开始时(player:Player):
	super.触发器_战斗开始时(player)
	player.beat_attack+=1

func 触发器_战斗结束后(player:Player):
	super.触发器_战斗结束后(player)
	player.beat_attack-=1
	
