extends BaseSpell

func 法术使用处理():
	# Placeholder for selecting a minion and buffing it
	# This would involve presenting minions to the player for selection
	var selected_minion = player.选择随从() # Placeholder for minion selection
	if selected_minion and selected_minion is BaseMinion:
		var buff_value: int = 2
		if is_gold:
			buff_value = 4
		var 加成 = AttributeBonus.build(
			'困倦的法师加成',
			Vector2i(buff_value, buff_value),
			str(lushi_id)
		)
		(selected_minion as BaseMinion).属性加成(加成, true) # Permanent buff
		
		# If it's a Naga, give it Reborn
		if Enums.CardRace.纳迦 in (selected_minion as BaseMinion).race:
			(selected_minion as BaseMinion).复生 = true
			print("困倦的法师触发：纳迦获得复生")
