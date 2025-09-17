extends Roar

func _具体战吼方法接口():
	# 增强酒馆中的元素
	var tavern_elements = 触发卡.player.酒馆.filter(func(card): return card is BaseMinion and (Enums.CardRace.元素 in (card as BaseMinion).race))
	for element in tavern_elements:
		var buff_value: int = 1
		if 触发卡.is_gold:
			buff_value = 2
		var 加成 = AttributeBonus.build(
			'农场热舞旋风战吼加成',
			Vector2i(buff_value, buff_value),
			str(触发卡.lushi_id)
		)
		(element as BaseMinion).属性加成(加成, true)
