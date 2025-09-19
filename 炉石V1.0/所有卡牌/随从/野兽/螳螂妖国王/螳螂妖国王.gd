extends BaseMinion

@export var DuoGameExclusive:bool = true

func 信号绑定():
	player.队伍传递信号.connect(_on_队伍传递) # Assuming this signal exists for Duo mode

func _on_队伍传递(passed_card: CardEntity):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	if passed_card == self: # If this card was passed
		_trigger_keyword_gain()

func _trigger_keyword_gain():
	var keywords: Array[String] = ['圣盾', '嘲讽', '复生', '剧毒', '烈毒', '风怒', '潜行']
	var random_keyword: String = keywords.pick_random()
	# Assuming there's a method to add keywords to a minion
	# For now, we'll print the keyword and apply a placeholder effect
	print("螳螂妖国王触发：获得关键词 %s" % random_keyword)
	# Placeholder for adding the keyword to this minion
	# This would involve setting the appropriate property (e.g., 圣盾 = true, 嘲讽 = true, etc.)
