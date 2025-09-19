extends Roar

func _具体战吼方法接口():
	var base_health_buff: int = 2
	if 触发卡.is_gold:
		base_health_buff = 4

	# 每有一个在上一场战斗中死亡的友方随从都会提高
	var total_health_buff = base_health_buff + 触发卡._dead_minions_last_combat

	# 使一个友方随从获得生命值
	var target_minion: BaseMinion = 触发卡.player.获取战场上的牌().filter(func(m): return m is BaseMinion).pick_random()
	if target_minion:
		var 加成 = AttributeBonus.build(
			'壳中小精灵战吼加成',
			Vector2i(0, total_health_buff),
			str(触发卡.lushi_id)
		)
		target_minion.属性加成(加成, true)
