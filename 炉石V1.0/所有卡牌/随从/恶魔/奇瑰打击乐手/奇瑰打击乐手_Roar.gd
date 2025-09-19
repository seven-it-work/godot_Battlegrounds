extends Roar

func _具体战吼方法接口():
	var discover_count: int = 1 * 触发卡.获取倍率() # 1 for normal, 2 for golden
	for i in discover_count:
		# Assuming there's a method to discover demon cards
		# This is a placeholder implementation
		print('奇瑰打击乐手触发：发现恶魔牌并对英雄造成伤害')
		# Assuming there's a way to deal damage to hero
		# 触发卡.player.英雄受伤信号.emit(discovered_card_level)
