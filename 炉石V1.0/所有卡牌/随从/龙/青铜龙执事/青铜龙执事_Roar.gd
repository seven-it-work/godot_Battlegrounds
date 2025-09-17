extends Roar

func _具体战吼方法接口():
	var buff_value: int = 1
	if 触发卡.is_gold:
		buff_value = 2

	var buff_vector = Vector2i(buff_value, 0)

	for minion in 触发卡.player.获取战场上的牌():
		if minion is BaseMinion and (Enums.CardRace.龙 in minion.race):
			var 加成 = AttributeBonus.build(
				'青铜龙执事战吼加成',
				buff_vector,
				str(触发卡.lushi_id)
			)
			(minion as BaseMinion).属性加成(加成, true) # Permanent buff
