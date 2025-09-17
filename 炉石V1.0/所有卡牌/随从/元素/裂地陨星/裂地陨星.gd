extends BaseMinion

func 信号绑定():
	player.出售随从信号.connect(_on_出售随从)

func _on_出售随从(sold_minion: BaseMinion):
	if sold_minion == self:
		_trigger_element_sale_buff()

func _trigger_element_sale_buff():
	# Assuming player.获取已出售元素数量() exists to count sold elementals
	# For now, we'll simulate with a placeholder
	var sold_elementals_count: int = player.获取已出售元素数量() # Placeholder
	var buff_value: int = sold_elementals_count
	if is_gold:
		buff_value *= 2 # Golden version doubles the buff

	var 加成 = AttributeBonus.build(
		'裂地陨星加成',
		Vector2i(buff_value, buff_value),
		str(lushi_id)
	)
	属性加成(加成, true) # Permanent buff
	print("裂地陨星触发：根据已出售元素数量 %d 获得属性加成" % sold_elementals_count)
