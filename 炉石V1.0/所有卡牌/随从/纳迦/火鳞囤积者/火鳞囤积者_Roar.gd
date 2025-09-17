extends Roar

func _具体战吼方法接口():
	var rings_to_get: int = 1
	if 触发卡.is_gold:
		rings_to_get = 2

	for i in rings_to_get:
		# 获取一张闪亮的戒指
		var ring_spell = CardUtils.get_card('闪亮的戒指', 触发卡.player)
		触发卡.player.添加卡片(ring_spell, Enums.CardPosition.手牌, -1, true)
