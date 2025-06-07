
extends BaseCard
#在战斗中，每当你召唤一个随从，使你最右边的野兽永久获得+6/+6。

func 触发器_召唤他人(召唤card:BaseCard,player:Player):
	super.触发器_召唤他人(召唤card,player)
	var list=player.get_minion().filter(func(card:BaseCard): return card.race.has(BaseCard.RaceEnum.BEAST))
	if list.size()<=0:
		return
	var back=list.back()
	back.add_atk(self,3*(2 if is_gold else 1),player,true)
	back.add_hp(self,3*(2 if is_gold else 1),player,true)
	pass
