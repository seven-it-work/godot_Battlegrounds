extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	# Assuming player.鲜血宝石属性值 exists to get the current Blood Gem stats
	# For now, we'll simulate by getting the current Blood Gem bonus
	var blood_gem_stats: Vector2i = 触发卡.player.鲜血宝石加成 # Placeholder
	var golem_stats: Vector2i = blood_gem_stats
	if 触发卡.is_gold:
		golem_stats *= 2 # Golden version doubles the stats

	# Assuming '鲜血宝石魔像' is the token name for the summoned minion
	var blood_gem_golem = CardUtils.get_card('鲜血宝石魔像', 触发卡.player)
	if blood_gem_golem and blood_gem_golem is BaseMinion:
		# Set the golem's stats to match the Blood Gem stats
		(blood_gem_golem as BaseMinion).基础攻击力 = golem_stats.x
		(blood_gem_golem as BaseMinion).基础生命值 = golem_stats.y
		blood_gem_golem.is_gold = 触发卡.is_gold
		触发卡.player.添加卡片(blood_gem_golem, Enums.CardPosition.战场, -1, true) # Summon to battlefield
		print("腐化的棘刺野猪人触发亡语：召唤属性值为 %s 的鲜血宝石魔像" % golem_stats)
