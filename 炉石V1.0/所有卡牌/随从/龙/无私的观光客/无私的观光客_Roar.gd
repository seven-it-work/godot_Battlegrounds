extends Roar

func _具体战吼方法接口():
	var increase: int = 1 * 触发卡.获取倍率() # +1 for normal, +2 for golden
	# Assuming there's a way to increase team coin cap
	# This is a placeholder implementation
	print('无私的观光客触发：队伍铸币上限提高 %d 枚' % increase)
	# 触发卡.player.铸币上限 += increase
	# if 触发卡.player.队友:
	# 	触发卡.player.队友.铸币上限 += increase
