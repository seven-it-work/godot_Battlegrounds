
extends BaseCard
func 触发器_使用其他卡牌(使用的卡牌:BaseCard,player:Player,目标卡片:BaseCard):
	super.触发器_使用其他卡牌(使用的卡牌,player,目标卡片)
	if 使用的卡牌.cardType==BaseCard.CardTypeEnum.TAVERN:
		var minion=player.tavern.get_all_minion().pick_random() as BaseCard
		if !minion:
			return
		# 随机恶魔
		var 目标对象=player.get_minion().filter(func(card:BaseCard):
			if card.uuid==uuid:
				return false
			return card.race.has(BaseCard.RaceEnum.DEMON)).pick_random()
		目标对象.add_atk(self,minion.atk_bonus(player)*(2 if is_gold else 1),player)
		目标对象.add_hp(self,minion.hp_bonus(player)*(2 if is_gold else 1),player)
	pass
