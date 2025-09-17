extends BaseSpell

func 法术使用处理():
	# Assuming player.酒馆法术生命值加成 exists to track the bonus
	# For now, we'll simulate by incrementing a counter
	var buff_value: int = 1
	if is_gold:
		buff_value = 2
	player.酒馆法术生命值加成 += buff_value # Permanently increase Tavern Spell health bonus
	print("宁静的冥想者触发：酒馆法术生命值加成增加 %d" % buff_value)
