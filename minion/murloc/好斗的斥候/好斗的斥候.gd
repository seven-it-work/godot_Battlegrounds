extends BaseCard
func 手牌触发器_战斗开始时(player:Player):
	var card=preload("uid://dhy4wb5l24kap").instantiate()
	card.atk=self.atk_bonus()*(2 if is_gold else 1)
	card.hp=self.hp_bonus()*(2 if is_gold else 1)
	player.add_card_in_bord(card)
	pass
