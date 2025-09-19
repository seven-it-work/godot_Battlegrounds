extends Roar

func _具体战吼方法接口():
	var gem_count: int = 1 * 触发卡.获取倍率() # 1 for normal, 2 for golden
	var other_minions: Array = 触发卡.player.获取战场上的牌().filter(func(m): return m != 触发卡)
	for minion in other_minions:
		for i in gem_count:
			# Assuming there's a method to use blood gems on minions
			# This is a placeholder implementation
			print('宝石走私商触发：对 %s 使用鲜血宝石' % minion.名称)
