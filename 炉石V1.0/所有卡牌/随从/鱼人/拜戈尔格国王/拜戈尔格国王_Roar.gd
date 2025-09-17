extends Roar

func _具体战吼方法接口():
	var buff_atk: int = 2 * 触发卡.获取倍率() # +2 for normal, +4 for golden
	var buff_hp: int = 3 * 触发卡.获取倍率() # +3 for normal, +6 for golden
	var buff_vector: Vector2i = Vector2i(buff_atk, buff_hp)
	var other_murlocs: Array = 触发卡.player.获取战场上的牌().filter(func(m): return m != 触发卡 and (Enums.CardRace.鱼人 in (m as BaseMinion).race))
	for murloc in other_murlocs:
		var 加成 = AttributeBonus.build(
			'拜戈尔格国王加成',
			buff_vector,
			str(触发卡.lushi_id)
		)
		(murloc as BaseMinion).属性加成(加成, true) # Permanent buff
