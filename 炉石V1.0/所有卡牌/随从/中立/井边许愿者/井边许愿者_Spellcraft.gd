extends Spellcraft

func _具体塑造法术方法接口():
	# 传递一个不同的非金色随从（井边许愿者除外）
	var available_minions = 触发卡.player.获取战场上的牌().filter(func(m): 
		return m is BaseMinion and not m.is_gold and m.名称 != "井边许愿者"
	)
	
	if not available_minions.is_empty():
		var target_minion = available_minions.pick_random()
		# 传递随从给队友
		# 这里假设有传递机制，实际实现可能需要更复杂的逻辑
		print("井边许愿者触发塑造法术：传递 %s 给队友" % target_minion.名称)
