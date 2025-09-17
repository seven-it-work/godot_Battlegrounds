extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	# Assuming player.获取最先死亡的机械() exists to get the first dead mechs
	# For now, we'll simulate by getting random mechs
	var mechs_to_summon: int = 2
	if 触发卡.is_gold:
		mechs_to_summon = 4 # Golden version summons 4 mechs

	for i in mechs_to_summon:
		var dead_mech = player.获取最先死亡的机械() # Placeholder for getting first dead mech
		if dead_mech:
			# Summon the mech to the battlefield
			player.添加卡片(dead_mech, Enums.CardPosition.战场, -1, true) # Summon to battlefield
			print("坎格尔的学徒触发亡语：召唤最先死亡的机械")
