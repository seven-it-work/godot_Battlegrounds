extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	var spell_count: int = 2 * 触发卡.获取倍率() # 2 for normal, 4 for golden
	for i in spell_count:
		# Assuming there's a method to get random spellcraft spells
		# This is a placeholder implementation
		print('库斯卡工兵触发：获取塑造法术牌')
