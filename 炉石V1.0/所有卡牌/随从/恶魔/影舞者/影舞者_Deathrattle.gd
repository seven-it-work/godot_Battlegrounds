extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	# Assuming '富足之杖' is the token name for the Tavern Spell
	var staff_of_enrichment = CardUtils.get_card('富足之杖', 触发卡.player)
	if staff_of_enrichment:
		staff_of_enrichment.is_gold = 触发卡.is_gold
		触发卡.player.添加卡片(staff_of_enrichment, Enums.CardPosition.手牌, -1, true) # Add to hand
		print("影舞者触发亡语：获取富足之杖")
