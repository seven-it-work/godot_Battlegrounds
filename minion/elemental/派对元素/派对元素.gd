extends BaseCard
func 触发器_使用其他卡牌(使用的卡牌:BaseCard,player:Player,目标卡片:BaseCard):
	if !使用的卡牌.race.has(RaceEnum.ELEMENTAL):
		return
	var one=player.get_minion().filter(func(card):
		if card.uuid==使用的卡牌.uuid:
			return false
		if !card.race.has(RaceEnum.ELEMENTAL):
			return false
		return true
		).pick_random()
	if !one:
		return
	for i in 2 if is_gold else 1:
		one.add_atk(self,1+player.元素加成.x,player)
		one.add_hp(self,1+player.元素加成.y,player)
		pass
	pass
