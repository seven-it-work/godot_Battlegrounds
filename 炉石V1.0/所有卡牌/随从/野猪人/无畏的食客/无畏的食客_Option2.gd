extends BaseSpell

func 法术使用处理():
	var gem_count: int = 4 * 获取倍率() # 4 for normal, 8 for golden
	for i in gem_count:
		var gem = CardUtils.get_card('鲜血宝石', 触发卡.player)
		gem.is_gold = 触发卡.is_gold
		触发卡.player.添加卡片(gem, Enums.CardPosition.手牌, -1, true)
