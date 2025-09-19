extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	var gems_per_quilboar: int = 3
	if 触发卡.is_gold:
		gems_per_quilboar = 6

	# 对你的所有野猪人各使用鲜血宝石
	var friendly_quilboars = 触发卡.player.获取战场上的牌().filter(func(m): return m is BaseMinion and (Enums.CardRace.野猪人 in (m as BaseMinion).race))
	for quilboar in friendly_quilboars:
		for i in gems_per_quilboar:
			var gem = CardUtils.get_card('鲜血宝石', 触发卡.player)
			# 应用鲜血宝石效果
			var buff_vector = 触发卡.player.鲜血宝石加成
			var 加成 = AttributeBonus.build('鲜血宝石', buff_vector, str(gem.lushi_id))
			(quilboar as BaseMinion).属性加成(加成, true)
