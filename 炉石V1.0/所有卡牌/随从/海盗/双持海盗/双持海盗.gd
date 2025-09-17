extends BaseMinion

@export var _gold_spent_counter: int = 0
@export var _gold_spent_threshold: int = 5

func 信号绑定():
	player.本回合花费金币信号.connect(_on_本回合花费金币)

func _on_本回合花费金币(amount: int):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return

	_gold_spent_counter += amount
	while _gold_spent_counter >= _gold_spent_threshold:
		_gold_spent_counter -= _gold_spent_threshold
		_trigger_pirate_buff()

func _trigger_pirate_buff():
	var buff_value: int = 4
	if is_gold:
		buff_value = 8

	# 使两个友方海盗获得属性
	var friendly_pirates = player.获取战场上的牌().filter(func(m): return m is BaseMinion and (Enums.CardRace.海盗 in (m as BaseMinion).race))
	for i in range(min(2, friendly_pirates.size())):
		var pirate = friendly_pirates[i]
		var 加成 = AttributeBonus.build(
			'双持海盗加成',
			Vector2i(buff_value, buff_value),
			str(lushi_id)
		)
		(pirate as BaseMinion).属性加成(加成, true)
