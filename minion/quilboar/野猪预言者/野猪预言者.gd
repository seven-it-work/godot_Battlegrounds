extends BaseCard

func 触发器_使用其他卡牌(使用的卡牌:BaseCard,player:Player,目标卡片:BaseCard):
	if !使用的卡牌.race.has(RaceEnum.QUILBOAR):
		return
	for i in 2 if is_gold else 1:
		player.add_card_in_handler(preload("uid://c84v1i3ulob37").instantiate())
	pass
