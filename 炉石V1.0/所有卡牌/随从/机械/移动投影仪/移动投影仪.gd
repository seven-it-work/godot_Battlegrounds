extends BaseMinion

func 信号绑定():
	player.随从攻击信号.connect(_on_随从攻击) # Assuming this signal exists

func _on_随从攻击(攻击者: BaseMinion, 目标: CardEntity):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	if 攻击者 == self: # 当本随从攻击时
		_trigger_magnetic_mech_reward()

func _trigger_magnetic_mech_reward():
	var cards_to_get: int = 1
	if is_gold:
		cards_to_get = 2

	for i in cards_to_get:
		# 随机获取一张磁力机械牌
		var magnetic_mech_data = player.获取随机磁力机械数据() # Placeholder
		if magnetic_mech_data:
			var new_mech = CardUtils.get_card(magnetic_mech_data.nameCN, player)
			player.添加卡片(new_mech, Enums.CardPosition.手牌, -1, true)
