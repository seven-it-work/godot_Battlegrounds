extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	# Assuming '变换之潮' is the token name for the spell
	var tide_of_change = CardUtils.get_card('变换之潮', 触发卡.player)
	if tide_of_change:
		tide_of_change.is_gold = 触发卡.is_gold
		触发卡.player.添加卡片(tide_of_change, Enums.CardPosition.手牌, -1, true) # Add to hand
		print("沉睡的巫术师触发亡语：获取变换之潮")
