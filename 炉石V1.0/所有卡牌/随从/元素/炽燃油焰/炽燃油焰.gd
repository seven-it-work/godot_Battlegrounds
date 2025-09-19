extends BaseMinion

func 信号绑定():
	player.回合结束信号.connect(_on_回合结束)

func _on_回合结束():
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	_trigger_tavern_element_buff()

func _trigger_tavern_element_buff():
	# Assuming player.酒馆 exists and contains cards
	# For now, we'll simulate by getting all cards in the tavern
	var tavern_cards: Array = player.酒馆 # Placeholder
	var element_cards: Array = tavern_cards.filter(func(card): return card.card_type == Enums.CardType.随从 and (Enums.CardRace.元素 in (card as BaseMinion).race))
	
	for element in element_cards:
		if element is BaseMinion:
			var buff_value: int = 1
			if is_gold:
				buff_value = 2
			var 加成 = AttributeBonus.build(
				'炽燃油焰加成',
				Vector2i(buff_value, buff_value),
				str(lushi_id)
			)
			(element as BaseMinion).属性加成(加成, true) # Permanent buff
	print("炽燃油焰触发：酒馆中的元素获得属性加成")
