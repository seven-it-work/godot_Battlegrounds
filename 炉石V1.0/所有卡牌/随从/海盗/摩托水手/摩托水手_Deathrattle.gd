extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	var reduction: int = 1 * 触发卡.获取倍率() # 1 for normal, 2 for golden
	# Assuming player has a property to track tavern upgrade cost reduction
	# This is for Duo mode, so it affects the team's tavern upgrade cost
	触发卡.player.酒馆升级费用减少 += reduction
