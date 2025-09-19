extends BaseMinion

func 信号绑定():
	player.回合结束信号.connect(_on_回合结束)

func _on_回合结束():
	if 卡片所在位置 != Enums.CardPosition.战场:
		return

	var buff_value: int = 1
	if is_gold:
		buff_value = 2
	player.酒馆法术攻击力加成 += buff_value # Permanently increase Tavern Spell attack bonus
