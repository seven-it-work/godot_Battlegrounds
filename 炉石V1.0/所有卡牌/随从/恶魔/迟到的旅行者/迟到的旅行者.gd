extends BaseMinion

func 信号绑定():
	player.出售随从信号.connect(_on_出售随从)

func _on_出售随从(sold_minion: BaseMinion):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	if sold_minion == self: # 当出售本随从时
		_trigger_spell_copy()

func _trigger_spell_copy():
	var copies_to_get: int = 1
	if is_gold:
		copies_to_get = 2

	# 获取酒馆中一个酒馆法术的复制
	var tavern_spells = player.酒馆.filter(func(card): return card is BaseSpell)
	if not tavern_spells.is_empty():
		var target_spell = tavern_spells.pick_random()
		for i in copies_to_get:
			var spell_copy = CardUtils.get_card(target_spell.名称, player)
			player.添加卡片(spell_copy, Enums.CardPosition.手牌, -1, true)
