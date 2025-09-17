extends BaseMinion

func 信号绑定():
	player.使用卡牌信号.connect(_on_使用卡牌)

func _on_使用卡牌(used_card: CardEntity):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	if used_card is BaseSpell: # 施放酒馆法术后
		_trigger_demon_consume()

func _trigger_demon_consume():
	# 另一个友方恶魔会吞食酒馆中的一个随从以获得其属性值
	var other_demons = player.获取战场上的牌().filter(func(m): return m is BaseMinion and m != self and (Enums.CardRace.恶魔 in (m as BaseMinion).race))
	if not other_demons.is_empty():
		var consuming_demon = other_demons.pick_random()
		var tavern_minions = player.酒馆.filter(func(card): return card is BaseMinion)
		if not tavern_minions.is_empty():
			var target_minion = tavern_minions.pick_random()
			var multiplier: int = 1
			if is_gold:
				multiplier = 2
			
			# 恶魔获得目标随从的属性值
			var target_stats = (target_minion as BaseMinion).获取带加成属性()
			var 加成 = AttributeBonus.build(
				'狂蝠恐惧卫士吞食加成',
				Vector2i(target_stats.x * multiplier, target_stats.y * multiplier),
				str(lushi_id)
			)
			(consuming_demon as BaseMinion).属性加成(加成, true)
			
			# 从酒馆中移除被吞食的随从
			player.酒馆.erase(target_minion)
			target_minion.queue_free()
