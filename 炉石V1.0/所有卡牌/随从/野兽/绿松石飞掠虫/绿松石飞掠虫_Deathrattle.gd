extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	# Assuming player.获取甲虫随从() exists to get beetle minions
	# For now, we'll simulate by getting all friendly minions and filtering for beetles
	var beetle_minions: Array = player.获取战场上的牌().filter(func(m): return m.名称.contains("甲虫")) # Placeholder
	for beetle in beetle_minions:
		if beetle is BaseMinion:
			var buff_value: int = 1
			if 触发卡.is_gold:
				buff_value = 2
			var 加成 = AttributeBonus.build(
				'绿松石飞掠虫加成',
				Vector2i(buff_value, buff_value),
				str(触发卡.lushi_id)
			)
			(beetle as BaseMinion).属性加成(加成, true) # Permanent buff

	# Summon a beetle minion
	var beetle_count: int = 1
	if 触发卡.is_gold:
		beetle_count = 2
	for i in beetle_count:
		var beetle = CardUtils.get_card('甲虫', 触发卡.player) # Assuming '甲虫' is the token name
		if beetle:
			beetle.is_gold = 触发卡.is_gold
			触发卡.player.添加卡片(beetle, Enums.CardPosition.战场, -1, true) # Summon to battlefield
