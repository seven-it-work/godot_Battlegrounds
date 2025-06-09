
extends BaseCard

func 触发器_使用其他卡牌(使用的卡牌:BaseCard,player:Player,目标卡片:BaseCard):
	super.触发器_使用其他卡牌(使用的卡牌,player,目标卡片)
	if 使用的卡牌.cardType==BaseCard.CardTypeEnum.TAVERN:
		for i in 2 if is_gold else 1:
			# 对玩家造成伤害
			player.player_hp_add(-1)
			for j in player.get_minion().filter(func(card:BaseCard): return card.race.has(BaseCard.RaceEnum.DEMON)):
				j.add_atk(self,1,player)
				j.add_hp(self,1,player)
	pass
	
