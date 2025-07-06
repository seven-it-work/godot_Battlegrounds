extends CardData

func 触发器_攻击后(被攻击者:CardData):
	var 被触发的亡语随从:CardData
	for i:CardData in player.获取战场中的牌():
		if i.是否存在亡语():
			被触发的亡语随从=i;
			break
	if 被触发的亡语随从:
		for i in 获取是否为金色的倍率():
			被触发的亡语随从.触发器_亡语(self)
	pass
