extends BaseMinion

func 信号绑定():
	player.出售随从信号.connect(_on_出售随从)

func _on_出售随从(sold_minion: BaseMinion):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	if sold_minion == self: # 当出售本随从时
		_trigger_tavern_refresh_and_steal()

func _trigger_tavern_refresh_and_steal():
	var pirates_to_steal: int = 1
	if is_gold:
		pirates_to_steal = 2

	# 刷新酒馆，使其中变为海盗
	player.酒馆刷新信号.emit()
	# 假设刷新后酒馆中的随从都变为海盗
	
	# 然后偷取海盗
	for i in pirates_to_steal:
		var tavern_pirates = player.酒馆.filter(func(card): return card is BaseMinion and (Enums.CardRace.海盗 in (card as BaseMinion).race))
		if not tavern_pirates.is_empty():
			var stolen_pirate = tavern_pirates.pick_random()
			player.酒馆.erase(stolen_pirate)
			player.添加卡片(stolen_pirate, Enums.CardPosition.手牌, -1, true)
