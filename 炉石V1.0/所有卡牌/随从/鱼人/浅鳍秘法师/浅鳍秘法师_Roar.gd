extends Roar

func _具体战吼方法接口():
	var bonus_atk: int = 1 * 触发卡.获取倍率() # +1 for normal, +2 for golden
	# Assuming player has a property to track tavern spell buff bonuses
	触发卡.player.酒馆法术攻击力加成 += bonus_atk
