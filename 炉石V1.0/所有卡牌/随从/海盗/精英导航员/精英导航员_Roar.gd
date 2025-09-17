extends Roar

func _具体战吼方法接口():
	var pirates_to_golden: int = 1
	if 触发卡.is_gold:
		pirates_to_golden = 2

	# 使等级4或以下的友方海盗变为金色
	var eligible_pirates = 触发卡.player.获取战场上的牌().filter(func(m): 
		return m is BaseMinion and (Enums.CardRace.海盗 in (m as BaseMinion).race) and m.tier <= 4
	)
	
	for i in range(min(pirates_to_golden, eligible_pirates.size())):
		(eligible_pirates[i] as BaseMinion).is_gold = true
