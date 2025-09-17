extends BaseMinion

var _avenge_count: int = 0
var _avenge_threshold: int = 4

func 信号绑定():
	player.随从死亡信号.connect(_on_随从死亡)

func _on_随从死亡(死亡随从: BaseMinion):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	if 死亡随从.player == player: # Only count friendly minion deaths
		_avenge_count += 1
		if _avenge_count >= _avenge_threshold:
			_avenge_count = 0 # Reset for next trigger
			_trigger_avenge()

func _trigger_avenge():
	# Assuming player.鲜血宝石生命值加成 exists to track the bonus
	# For now, we'll simulate by incrementing a counter
	var buff_value: int = 1
	if is_gold:
		buff_value = 2
	player.鲜血宝石生命值加成 += buff_value # Permanently increase Blood Gem health bonus
	print("睡梦织棘者触发复仇：鲜血宝石生命值加成增加 %d" % buff_value)
