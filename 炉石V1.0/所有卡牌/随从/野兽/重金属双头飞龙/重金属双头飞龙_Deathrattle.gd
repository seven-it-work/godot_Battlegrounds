extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	var 相邻: Array = ArrayUtils.get_neighboring_data(触发卡, 触发卡.player.获取战场上的牌())
	if 相邻.is_empty():
		return
	var 目标随从 = 相邻.pick_random()
	if 目标随从 and 目标随从.战吼.size() > 0:
		for roar in 目标随从.战吼:
			roar._具体战吼方法接口()
