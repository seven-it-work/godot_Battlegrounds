extends BaseMinion

func 信号绑定():
	player.开始回合信号.connect(_on_开始回合)

func _on_开始回合():
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	_trigger_golden_minion_gold()

func _trigger_golden_minion_gold():
	# Assuming player.获取金色随从数量() exists to count golden minions
	# For now, we'll simulate by counting golden minions on the board
	var golden_minions: Array = player.获取战场上的牌().filter(func(m): return (m as BaseMinion).is_gold)
	var gold_to_gain: int = golden_minions.size()
	if is_gold:
		gold_to_gain *= 2 # Golden version doubles the gold gained

	player.当前金币 += gold_to_gain # Add gold to current gold
	print("偷金捣蛋鬼触发：根据金色随从数量 %d 获得 %d 枚铸币" % [golden_minions.size(), gold_to_gain])
