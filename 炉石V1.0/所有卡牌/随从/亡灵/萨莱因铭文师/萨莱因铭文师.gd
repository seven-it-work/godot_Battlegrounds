extends BaseMinion

func 信号绑定():
	player.随从死亡信号.connect(_on_随从死亡)

func _on_随从死亡(死亡随从: BaseMinion):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	if 死亡随从.player == player: # Only count friendly minion deaths
		var buff_value: int = 1
		if is_gold:
			buff_value = 2
		var 加成 = AttributeBonus.build(
			'萨莱因铭文师加成',
			Vector2i(buff_value, buff_value),
			str(lushi_id)
		)
		属性加成(加成, true) # Permanent buff
