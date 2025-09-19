extends BaseSpell

func 法术使用处理():
	# Placeholder for selecting a minion and giving it Divine Shield until next turn
	# This would involve presenting minions to the player for selection
	var selected_minion = player.选择随从() # Placeholder for minion selection
	if selected_minion and selected_minion is BaseMinion:
		(selected_minion as BaseMinion).圣盾 = true
		# Assuming there's a way to remove Divine Shield at the start of next turn
		# For now, we'll print the effect
		print("闪鳞纳迦触发：给随从圣盾直到下个回合")
