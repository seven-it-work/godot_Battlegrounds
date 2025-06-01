extends Roar

func 战吼(触发者:BaseCard,player:Player,目标对象:BaseCard):
	if player.is_fight:
		return
	var tavern:Tavern=player.tavern
	if tavern.get_all_minion().size()<=0:
		return
	var eat_card:BaseCard=tavern.get_all_minion().pick_random()
	触发者.add_atk(触发者,eat_card.atk_bonus()*2 if 触发者.is_gold else eat_card.atk_bonus(),player)
	触发者.add_hp( 触发者, eat_card.hp_bonus()*2 if 触发者.is_gold else  eat_card.hp_bonus(),player)
	pass
