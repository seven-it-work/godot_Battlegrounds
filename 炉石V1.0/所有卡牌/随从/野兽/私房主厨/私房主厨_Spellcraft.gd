extends BaseSpell

func 法术使用处理():
	# Placeholder for selecting a minion and getting a card of the same type
	# This would involve presenting minions to the player for selection
	# and then getting a random card of the same race/type
	var selected_minion_data = player.选择随从() # Placeholder for minion selection
	if selected_minion_data:
		var same_type_card = player.获取同类型随从(selected_minion_data.race) # Placeholder
		if same_type_card:
			player.添加卡片(same_type_card, Enums.CardPosition.手牌, -1, true) # Add to hand
			# Assuming player.队友.添加卡片(card) exists for Duo mode
			# For now, add to own hand and print
			player.添加卡片(same_type_card, Enums.CardPosition.手牌, -1, true)
			print("私房主厨触发：获取同类型牌并传递给队友")
