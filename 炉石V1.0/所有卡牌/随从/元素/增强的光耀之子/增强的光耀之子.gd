extends BaseMinion

var _buff_health_this_turn: bool = true # Tracks whether to buff health or attack

func 信号绑定():
	player.回合结束信号.connect(_on_回合结束)

func _on_回合结束():
	if 卡片所在位置 != Enums.CardPosition.战场:
		return

	var buff_value: int = 1
	if is_gold:
		buff_value = 2

	if _buff_health_this_turn:
		# 你的能使随从获得属性值的元素在本局对战中额外使随从获得生命值
		player.元素生命值加成 += buff_value
	else:
		# 你的能使随从获得属性值的元素在本局对战中额外使随从获得攻击力
		player.元素攻击力加成 += buff_value

	_buff_health_this_turn = not _buff_health_this_turn # Toggle buff type each turn
