extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	# Assuming '星元自动机' is the token name for the summoned minion
	var star_automaton = CardUtils.get_card('星元自动机', 触发卡.player)
	if star_automaton:
		star_automaton.is_gold = 触发卡.is_gold
		触发卡.player.添加卡片(star_automaton, Enums.CardPosition.战场, -1, true) # Summon to battlefield
		print("自动装配机触发亡语：召唤星元自动机")
