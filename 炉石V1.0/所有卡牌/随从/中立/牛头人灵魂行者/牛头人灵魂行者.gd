extends BaseMinion

func 信号绑定():
	player.开始回合信号.connect(_on_开始回合)

func _on_开始回合():
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	_trigger_tavern_spell_double_cast()

func _trigger_tavern_spell_double_cast():
	# Assuming player.酒馆法术双倍施放次数 exists to track remaining double casts
	# For now, we'll simulate by setting a counter
	var double_casts: int = 1
	if is_gold:
		double_casts = 2 # Golden version gives 2 double casts per turn
	player.酒馆法术双倍施放次数 += double_casts # Add to remaining double casts
	print("牛头人灵魂行者触发：本回合酒馆法术可双倍施放 %d 次" % double_casts)
