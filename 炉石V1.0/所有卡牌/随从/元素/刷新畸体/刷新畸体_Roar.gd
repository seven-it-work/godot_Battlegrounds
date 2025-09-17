extends Roar

func _具体战吼方法接口():
	var refresh_count: int = 2 * 触发卡.获取倍率() # 2 for normal, 4 for golden
	# Assuming player has a method to add free refreshes
	触发卡.player.免费刷新次数 += refresh_count
