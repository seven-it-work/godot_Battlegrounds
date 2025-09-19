extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	# 使你的纳迦获得属性（基于施放法术提升的值）
	var buff_value = 触发卡._naga_buff_value
	if buff_value > 0:
		var friendly_nagas = 触发卡.player.获取战场上的牌().filter(func(m): return m is BaseMinion and (Enums.CardRace.纳迦 in (m as BaseMinion).race))
		for naga in friendly_nagas:
			var 加成 = AttributeBonus.build(
				'显眼的骑手亡语加成',
				Vector2i(buff_value, buff_value),
				str(触发卡.lushi_id)
			)
			(naga as BaseMinion).属性加成(加成, true)
