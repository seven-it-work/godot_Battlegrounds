extends Roar

func _具体战吼方法接口():
	# 计算战队中不同的额外关键词数量
	var unique_keywords = {}
	var board_minions = 触发卡.player.获取战场上的牌()
	for minion in board_minions:
		if minion is BaseMinion:
			var base_minion = minion as BaseMinion
			if base_minion.圣盾: unique_keywords["圣盾"] = true
			if base_minion.嘲讽: unique_keywords["嘲讽"] = true
			if base_minion.风怒: unique_keywords["风怒"] = true
			if base_minion.复生: unique_keywords["复生"] = true
			if base_minion.剧毒: unique_keywords["剧毒"] = true
			if base_minion.烈毒: unique_keywords["烈毒"] = true
			if base_minion.潜行: unique_keywords["潜行"] = true
			if base_minion.是否为磁力: unique_keywords["磁力"] = true

	var buff_amount = unique_keywords.size()
	if buff_amount > 0:
		# 使你的其他随从获得属性
		var other_minions = board_minions.filter(func(m): return m != 触发卡)
		for minion in other_minions:
			if minion is BaseMinion:
				var 加成 = AttributeBonus.build(
					'黑客鱼人战吼加成',
					Vector2i(buff_amount, buff_amount),
					str(触发卡.lushi_id)
				)
				(minion as BaseMinion).属性加成(加成, true)
