extends BaseMinion

func 信号绑定():
	player.开始回合信号.connect(_on_开始回合)

func _on_开始回合():
	if 卡片所在位置 != Enums.CardPosition.战场:
		return

	var buff_value: int = 1
	if is_gold:
		buff_value = 2

	# 你的鲜血宝石在本局对战中使随从额外获得属性
	player.鲜血宝石加成 += Vector2i(buff_value, buff_value)
