extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	var summon_count: int = 1
	if 触发卡.is_gold:
		summon_count = 2

	# 获取队友战队中的随从（宽厚的驼鹿除外）
	var teammate_minions = 触发卡.player.队友.获取战场上的牌().filter(func(m): return m is BaseMinion and m.名称 != "宽厚的驼鹿")
	
	for i in range(min(summon_count, teammate_minions.size())):
		var target_minion = teammate_minions[i]
		var copy = CardUtils.get_card(target_minion.名称, 触发卡.player)
		if copy is BaseMinion:
			(copy as BaseMinion).生命值 = 1 # 将生命值变为1
			触发卡.player.召唤随从信号.emit(copy)
