extends BaseMinion

func 战斗开始时():
	if 卡片所在位置 != Enums.CardPosition.战场:
		return

	# 给敌方随从嘲讽和双倍伤害
	var enemy_minions = player.获取敌方战场上的牌()
	for minion in enemy_minions:
		if minion is BaseMinion:
			(minion as BaseMinion).嘲讽 = true
			# 双倍伤害效果通过修改伤害计算实现
			# 这里假设有一个属性来标记双倍伤害
			(minion as BaseMinion).双倍伤害 = true
