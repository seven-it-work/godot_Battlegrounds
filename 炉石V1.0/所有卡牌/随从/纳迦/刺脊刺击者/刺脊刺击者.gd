extends BaseMinion

func 信号绑定():
	player.使用卡牌信号.connect(_on_使用卡牌)

func _on_使用卡牌(used_card: CardEntity):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	if used_card is BaseSpell: # 施放法术时
		_trigger_random_keyword()

func _trigger_random_keyword():
	var available_keywords = [
		"圣盾", "嘲讽", "风怒", "复生", "剧毒", "烈毒", "潜行"
	]
	
	var random_keyword_index = randi_range(0, available_keywords.size() - 1)
	var chosen_keyword = available_keywords[random_keyword_index]
	
	match chosen_keyword:
		"圣盾": 圣盾 = true
		"嘲讽": 嘲讽 = true
		"风怒": 风怒 = true
		"复生": 复生 = true
		"剧毒": 剧毒 = true
		"烈毒": 烈毒 = true
		"潜行": 潜行 = true
	print("刺脊刺击者获得关键词：%s" % chosen_keyword)
