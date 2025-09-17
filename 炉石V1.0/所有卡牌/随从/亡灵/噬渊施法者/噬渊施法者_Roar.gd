extends Roar

func _具体战吼方法接口():
	# Assuming player.选择友方亡灵() exists to let player choose a friendly undead
	# and player.发现亡灵牌() exists to discover undead cards
	var selected_undead = player.选择友方亡灵() # Placeholder for undead selection
	if selected_undead and selected_undead is BaseMinion:
		# Destroy the selected undead
		await (selected_undead as BaseMinion).生命扣除(触发卡, 999) # Destroy it
		
		# Discover undead cards
		var discover_count: int = 1
		if 触发卡.is_gold:
			discover_count = 2 # Golden version discovers two
		
		for i in discover_count:
			var discovered_undead = player.发现亡灵牌() # Placeholder for undead discovery
			if discovered_undead:
				player.添加卡片(discovered_undead, Enums.CardPosition.手牌, -1, true) # Add to hand
				print("噬渊施法者触发：发现亡灵牌")
