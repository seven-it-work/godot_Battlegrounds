extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	var damage: int = 3
	var times: int = 1 * 触发卡.获取倍率() # 1 for normal, 2 for golden
	
	for i in times:
		# Damage all minions on battlefield
		var all_minions: Array = []
		all_minions.append_array(触发卡.player.获取战场上的牌())
		# Assuming there's a way to get opponent's minions
		# all_minions.append_array(触发卡.player.对手.获取战场上的牌())
		
		for minion in all_minions:
			if minion != 触发卡: # Don't damage self
				await (minion as BaseMinion).生命扣除(触发卡, damage)
