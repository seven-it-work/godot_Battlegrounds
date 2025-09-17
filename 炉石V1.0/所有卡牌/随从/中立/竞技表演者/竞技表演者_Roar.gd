extends Roar

func _具体战吼方法接口():
	var spells_to_discover: int = 1
	if 触发卡.is_gold:
		spells_to_discover = 2

	for i in spells_to_discover:
		# 发现一张酒馆法术牌
		var tavern_spell = 触发卡.player.获取随机酒馆法术数据() # Placeholder for getting random tavern spell
		if tavern_spell:
			var new_spell = CardUtils.get_card(tavern_spell.nameCN, 触发卡.player)
			触发卡.player.添加卡片(new_spell, Enums.CardPosition.手牌, -1, true)
