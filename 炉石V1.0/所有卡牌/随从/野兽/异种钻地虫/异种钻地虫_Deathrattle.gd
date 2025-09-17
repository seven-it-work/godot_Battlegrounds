extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	# 使你的野兽获得属性（基于复仇提升的值）
	var buff_value = 触发卡._beast_buff_value
	if buff_value > 0:
		var friendly_beasts = 触发卡.player.获取战场上的牌().filter(func(m): return m is BaseMinion and (Enums.CardRace.野兽 in (m as BaseMinion).race))
		for beast in friendly_beasts:
			var 加成 = AttributeBonus.build(
				'异种钻地虫亡语加成',
				Vector2i(buff_value, buff_value),
				str(触发卡.lushi_id)
			)
			(beast as BaseMinion).属性加成(加成, true)
