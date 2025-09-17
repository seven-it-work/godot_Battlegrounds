extends Roar

func _具体战吼方法接口():
	var dragon_cards_count: int = 1
	if 触发卡.is_gold:
		dragon_cards_count = 2 # Golden version gets two dragon cards

	for i in dragon_cards_count:
		# Assuming player.获取随机龙牌() exists to get a random dragon card
		var random_dragon = player.获取随机龙牌() # Placeholder
		if random_dragon:
			player.添加卡片(random_dragon, Enums.CardPosition.手牌, -1, true) # Add to hand
			print("活跃的奇想幼龙触发：获取随机龙牌")
