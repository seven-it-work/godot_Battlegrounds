extends BaseMinion

func 信号绑定():
	player.召唤随从信号.connect(_on_召唤随从)

func _on_召唤随从(召唤随从: BaseMinion):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	if 召唤随从.player == player: # Only friendly summons
		# 检查战队是否放不下（假设有7个位置）
		var board_minions = player.获取战场上的牌()
		if board_minions.size() >= 7: # 战队放不下时
			_trigger_undead_buff()

func _trigger_undead_buff():
	var buff_value: int = 2
	if is_gold:
		buff_value = 4

	# 使你的亡灵永久获得属性
	var friendly_undead = player.获取战场上的牌().filter(func(m): return m is BaseMinion and (Enums.CardRace.亡灵 in (m as BaseMinion).race))
	for undead in friendly_undead:
		var 加成 = AttributeBonus.build(
			'古墓捣蛋鬼加成',
			Vector2i(buff_value, buff_value),
			str(lushi_id)
		)
		(undead as BaseMinion).属性加成(加成, true)
