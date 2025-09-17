extends BaseSpell

func 法术使用处理():
	var buff_value: int = 3 * 获取倍率() # +3 for normal, +6 for golden
	var buff_vector: Vector2i = Vector2i(0, buff_value)
	var 加成 = AttributeBonus.build(
		'进化始祖抉择2',
		buff_vector,
		str(lushi_id)
	)
	player.当前随从.属性加成(加成, true) # Permanent buff
	player.当前随从.烈毒 = true # Grant Venomous
