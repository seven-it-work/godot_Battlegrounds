extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	var summon_count: int = 3 * 触发卡.获取倍率() # 3 for normal, 6 for golden
	var summon_pos: int = 触发卡.删除前的索引 if 触发卡.删除前的索引 != null else -1

	for i in summon_count:
		var skeleton = CardUtils.get_card('骷髅', 触发卡.player)
		skeleton.is_gold = 触发卡.is_gold
		触发卡.player.召唤随从(skeleton as BaseMinion, summon_pos + i)
