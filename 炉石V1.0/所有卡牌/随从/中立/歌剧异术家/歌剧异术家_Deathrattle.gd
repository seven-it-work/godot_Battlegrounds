extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	# 给所有鱼人烈毒
	var friendly_murlocs = 触发卡.player.获取战场上的牌().filter(func(m): return m is BaseMinion and (Enums.CardRace.鱼人 in (m as BaseMinion).race))
	for murloc in friendly_murlocs:
		(murloc as BaseMinion).烈毒 = true
