extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	var buff_value: int = 3
	var health_buff: int = 5
	if 触发卡.is_gold:
		buff_value = 6
		health_buff = 10

	# 使你的亡灵获得属性
	var friendly_undead = 触发卡.player.获取战场上的牌().filter(func(m): return m is BaseMinion and (Enums.CardRace.亡灵 in (m as BaseMinion).race))
	for undead in friendly_undead:
		var 加成 = AttributeBonus.build(
			'死亡管家莫罗斯加成',
			Vector2i(buff_value, health_buff),
			str(触发卡.lushi_id)
		)
		(undead as BaseMinion).属性加成(加成, true)
