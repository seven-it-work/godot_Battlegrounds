extends BaseMinion

@export var 圣盾:bool = true

func 信号绑定():
	player.使用卡牌信号.connect(_on_使用卡牌)

func _on_使用卡牌(used_card: CardEntity):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	if used_card is BaseSpell: # 施放酒馆法术时
		_trigger_divine_shield_buff()

func _trigger_divine_shield_buff():
	var buff_value: int = 3
	if is_gold:
		buff_value = 6

	# 使你具有圣盾的随从获得攻击力
	var board_minions = player.获取战场上的牌()
	for minion in board_minions:
		if minion is BaseMinion and (minion as BaseMinion).圣盾:
			var 加成 = AttributeBonus.build(
				'蓄能女沙皇加成',
				Vector2i(buff_value, 0),
				str(lushi_id)
			)
			(minion as BaseMinion).属性加成(加成, true)
