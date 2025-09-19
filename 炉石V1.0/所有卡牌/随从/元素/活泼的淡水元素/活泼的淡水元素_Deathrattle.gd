extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	var refresh_count: int = 2 * 触发卡.获取倍率() # 2 for normal, 4 for golden
	# Give free refreshes to self and teammate
	# Assuming there's a method to give free refreshes
	print('活泼的淡水元素触发：给队伍 %d 次免费刷新' % refresh_count)
	# This would involve calling a method to give free refreshes
	# 触发卡.player.获得免费刷新(refresh_count)
	# if 触发卡.player.队友:
	# 	触发卡.player.队友.获得免费刷新(refresh_count)
