extends Roar

func _具体战吼方法接口():
	# Buff a random dragon
	var dragons: Array = 触发卡.player.获取战场上的牌().filter(func(m): 
		return (Enums.CardRace.龙 in (m as BaseMinion).race)
	)
	
	if dragons.size() > 0:
		var target_dragon = dragons.pick_random()
		if target_dragon is BaseMinion:
			var buff_value: int = 5
			if 触发卡.is_gold:
				buff_value = 10 # Golden version gives +10 attack
			var 加成 = AttributeBonus.build(
				'燃翼加成',
				Vector2i(buff_value, 0), # Only attack
				str(触发卡.lushi_id)
			)
			(target_dragon as BaseMinion).属性加成(加成, true) # Permanent buff
			print("燃翼触发：给龙攻击力加成")
