extends BaseMinion

func 信号绑定():
	player.随从属性加成信号.connect(_on_随从属性加成)

func _on_随从属性加成(加成随从: CardEntity, 加成数据: AttributeBonus):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	if 加成随从 == self and 加成数据.atk_hp.x > 0: # If this minion gained attack
		_trigger_health_buff()

func _trigger_health_buff():
	var buff_value: int = 2
	if is_gold:
		buff_value = 4 # Golden version gives +4 health
	
	var friendly_minions: Array = player.获取战场上的牌()
	for minion in friendly_minions:
		if minion is BaseMinion:
			var 加成 = AttributeBonus.build(
				'采集者猎手加成',
				Vector2i(0, buff_value), # Only health
				str(lushi_id)
			)
			(minion as BaseMinion).属性加成(加成, true) # Permanent buff
			print("采集者猎手触发：给随从生命值加成")
