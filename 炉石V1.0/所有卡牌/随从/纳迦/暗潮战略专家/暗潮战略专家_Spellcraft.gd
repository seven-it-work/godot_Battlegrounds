extends Spellcraft

func _具体塑造法术方法接口():
	var cards_to_get: int = 1
	if 触发卡.is_gold:
		cards_to_get = 2

	for i in cards_to_get:
		# 随机获取一张等级1的纳迦牌（每回合都会升级）
		var naga_data = 触发卡.player.获取随机随从数据(Enums.CardRace.纳迦, 1) # Assuming tier 1
		if naga_data:
			var new_naga = CardUtils.get_card(naga_data.nameCN, 触发卡.player)
			触发卡.player.添加卡片(new_naga, Enums.CardPosition.手牌, -1, true)
