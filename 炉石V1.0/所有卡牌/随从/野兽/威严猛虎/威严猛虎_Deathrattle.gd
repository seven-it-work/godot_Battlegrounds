extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	var 列表:Array = 触发卡.player.获取战场上的牌()
	if 列表.is_empty():
		return
	var 目标:BaseMinion = null
	for i in range(列表.size() - 1, -1, -1): # Iterate from right to left
		var m = 列表[i]
		if m == 触发卡: # Exclude self
			continue
		if (Enums.CardRace.野兽 in (m as BaseMinion).race):
			目标 = m
			break # Found the rightmost beast
	if 目标:
		var buff_value: int = 5
		if 触发卡.is_gold:
			buff_value = 10 # Golden version gives +10/+10
		var 加成 = AttributeBonus.build(
			'威严猛虎加成',
			Vector2i(buff_value, buff_value),
			str(触发卡.lushi_id)
		)
		目标.属性加成(加成, true) # Permanent buff
