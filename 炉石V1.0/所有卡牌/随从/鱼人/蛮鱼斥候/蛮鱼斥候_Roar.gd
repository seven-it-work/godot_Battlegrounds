extends Roar

func _具体战吼方法接口():
	# Check if player controls other murlocs
	var other_murlocs: Array = 触发卡.player.获取战场上的牌().filter(func(m): 
		return m != 触发卡 and (Enums.CardRace.鱼人 in (m as BaseMinion).race)
	)
	
	if other_murlocs.size() > 0:
		var discover_count: int = 1
		if 触发卡.is_gold:
			discover_count = 2 # Golden version discovers two
		
		for i in discover_count:
			var discovered_murloc = 触发卡.player.发现鱼人牌() # Placeholder for murloc discovery
			if discovered_murloc:
				触发卡.player.添加卡片(discovered_murloc, Enums.CardPosition.手牌, -1, true) # Add to hand
				print("蛮鱼斥候触发：发现鱼人牌")
