extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	var bonus_atk: int = 1 * 触发卡.获取倍率() # +1 for normal, +2 for golden
	# Assuming player has a property to track elemental buff bonuses
	触发卡.player.元素攻击力加成 += bonus_atk
