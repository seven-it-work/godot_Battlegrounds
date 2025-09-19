extends BaseMinion

func 信号绑定():
	player.召唤随从信号.connect(_on_召唤随从)

func _on_召唤随从(召唤随从: BaseMinion):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	if !player.是否在战斗中():
		return
	if !(Enums.CardRace.野兽 in 召唤随从.race):
		return
	_trigger_rightmost_beast_buff()

func _trigger_rightmost_beast_buff():
	var 列表:Array = player.获取战场上的牌()
	if 列表.is_empty():
		return
	var 目标:BaseMinion = null
	for i in range(列表.size() - 1, -1, -1): # Iterate from right to left
		var m = 列表[i]
		if m == self: # Exclude self
			continue
		if (Enums.CardRace.野兽 in (m as BaseMinion).race):
			目标 = m
			break # Found the rightmost beast
	if 目标:
		var buff_value: int = 1
		if is_gold:
			buff_value = 2
		var 加成 = AttributeBonus.build(
			'温驯的雄鹿加成',
			Vector2i(buff_value, buff_value),
			str(lushi_id)
		)
		目标.属性加成(加成, true) # Permanent buff
