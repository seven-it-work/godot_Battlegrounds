extends BaseMinion

func 信号绑定():
	player.使用卡牌信号.connect(_on_使用卡牌)

func _on_使用卡牌(used_card: CardEntity):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	if used_card is BaseSpell: # 施放酒馆法术时
		_trigger_buff_by_type()

func _trigger_buff_by_type():
	var buff_value: int = 2
	var health_buff: int = 1
	if is_gold:
		buff_value = 4
		health_buff = 2

	# 给每个类型的各一个友方随从获得属性
	var board_minions = player.获取战场上的牌()
	var buffed_types = {}
	
	for minion in board_minions:
		if minion is BaseMinion:
			var minion_races = (minion as BaseMinion).race
			for race in minion_races:
				if not buffed_types.has(race):
					buffed_types[race] = true
					var 加成 = AttributeBonus.build(
						'救赎者娜拉加成',
						Vector2i(buff_value, health_buff),
						str(lushi_id)
					)
					(minion as BaseMinion).属性加成(加成, true)
					break # 每个类型只buff一个随从
