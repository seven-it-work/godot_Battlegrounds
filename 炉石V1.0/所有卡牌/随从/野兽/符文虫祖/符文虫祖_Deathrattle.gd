extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	# 在本局对战中，你的甲虫拥有属性加成
	if 触发卡._beetle_buff_value > 0:
		# 这里假设有一个全局的甲虫属性加成机制
		触发卡.player.甲虫属性加成 += Vector2i(触发卡._beetle_buff_value, 触发卡._beetle_buff_value)

	# 召唤甲虫
	var summon_count: int = 1
	if 触发卡.is_gold:
		summon_count = 2

	for i in summon_count:
		var beetle_token = CardUtils.get_card('甲虫', 触发卡.player)
		if beetle_token is BaseMinion:
			# 应用甲虫属性加成
			var 加成 = AttributeBonus.build(
				'符文虫祖甲虫加成',
				Vector2i(触发卡._beetle_buff_value, 触发卡._beetle_buff_value),
				str(触发卡.lushi_id)
			)
			(beetle_token as BaseMinion).属性加成(加成, true)
		触发卡.player.召唤随从信号.emit(beetle_token)
