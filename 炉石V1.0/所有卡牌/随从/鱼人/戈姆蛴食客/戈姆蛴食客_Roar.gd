extends Roar

func _具体战吼方法接口():
	_获取海鲜乱炖()

func _获取海鲜乱炖():
	# Assuming '海鲜乱炖' is the token name for the Tavern Spell
	var seafood_stew = CardUtils.get_card('海鲜乱炖', 触发卡.player)
	if seafood_stew:
		seafood_stew.is_gold = 触发卡.is_gold
		触发卡.player.添加卡片(seafood_stew, Enums.CardPosition.手牌, -1, true) # Add to hand
		print("戈姆蛴食客触发战吼：获取海鲜乱炖")
