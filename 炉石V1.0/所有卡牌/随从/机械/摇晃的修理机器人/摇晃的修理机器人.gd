extends BaseMinion

func 信号绑定():
	player.回合结束信号.connect(_on_回合结束)

func _on_回合结束():
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	_trigger_magnetic_attachment()

func _trigger_magnetic_attachment():
	# Assuming player.获取随机磁力机械() exists to get a random magnetic mech
	# For now, we'll simulate by getting a random mech from the tavern
	var random_magnetic_mech = player.获取随机磁力机械() # Placeholder
	if random_magnetic_mech:
		# Assuming player.磁力吸附(card1, card2) exists to attach magnetic cards
		# For now, we'll print the effect
		print("摇晃的修理机器人触发：磁力吸附随机磁力机械")
		# Placeholder for magnetic attachment logic
		# This would involve combining the stats and keywords of the two cards
