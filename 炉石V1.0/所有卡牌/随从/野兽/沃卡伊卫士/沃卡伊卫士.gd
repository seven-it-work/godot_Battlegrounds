extends BaseMinion

func 战斗开始时():
	if 卡片所在位置 != Enums.CardPosition.战场:
		return

	var battlefield = player.获取战场上的牌()
	var my_index = battlefield.find(self)
	if my_index == -1:
		return

	var adjacent_minions = ArrayUtils.get_neighboring_data(battlefield, my_index)
	for minion in adjacent_minions:
		if minion is BaseMinion:
			(minion as BaseMinion).圣盾 = true
