extends Roar

func _具体战吼方法接口():
	var bonus_hp: int = 1 * 触发卡.获取倍率() # +1 for normal, +2 for golden
	# Assuming player has a property to track elemental buff bonuses
	触发卡.player.元素生命值加成 += bonus_hp
