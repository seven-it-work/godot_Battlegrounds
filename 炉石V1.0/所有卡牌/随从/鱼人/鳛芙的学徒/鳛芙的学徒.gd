extends BaseMinion

func 信号绑定():
	player.回合结束信号.connect(_on_回合结束)

func _on_回合结束():
	if 卡片所在位置 != Enums.CardPosition.战场:
		return

	var buff_value: int = 1
	if is_gold:
		buff_value = 2

	var buff_vector = Vector2i(buff_value, buff_value)
	var 加成 = AttributeBonus.build(
		'鳛芙的学徒加成',
		buff_vector,
		str(lushi_id)
	)
	属性加成(加成, true) # Permanent buff

	# Gain a random keyword
	var keywords = ['圣盾', '嘲讽', '复生', '剧毒', '烈毒', '风怒', '潜行']
	var random_keyword = keywords.pick_random()
	
	match random_keyword:
		'圣盾':
			圣盾 = true
		'嘲讽':
			嘲讽 = true
		'复生':
			复生 = true
		'剧毒':
			剧毒 = true
		'烈毒':
			烈毒 = true
		'风怒':
			风怒 = true
		'潜行':
			潜行 = true
