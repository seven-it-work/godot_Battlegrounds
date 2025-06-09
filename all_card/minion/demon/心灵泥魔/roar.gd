extends Roar

func 战吼(触发者:BaseCard,player:Player,目标对象:BaseCard):
	if !目标对象:
		return
	if !目标对象.race.has(BaseCard.RaceEnum.DEMON):
		return
	var minion=player.tavern.get_all_minion().pick_random() as BaseCard
	if !minion:
		return
	目标对象.add_atk(触发者,minion.atk_bonus(player),player)
	目标对象.add_hp(触发者,minion.hp_bonus(player),player)
	pass
