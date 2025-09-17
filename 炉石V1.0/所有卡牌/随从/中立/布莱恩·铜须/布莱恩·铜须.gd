extends BaseMinion

func _ready():
	# Assuming player.战吼触发次数 exists to track battlecry triggers
	# For now, we'll simulate by setting a multiplier
	var multiplier: int = 2
	if is_gold:
		multiplier = 3 # Golden version triggers three times
	player.战吼触发次数 = multiplier # Set battlecry trigger multiplier
	print("布莱恩·铜须触发：战吼触发 %d 次" % multiplier)
