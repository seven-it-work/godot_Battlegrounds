extends CardData

func 使用触发监听(使用的卡片:CardData):
	super.使用触发监听(player,使用的卡片)
	if 使用的卡片.card_data.所在位置==Enums.CardPosition.战场:
		if 使用的卡片.card_data.是否属于种族(Enums.RaceEnum.DEMON):
			print("在你使用一张恶魔牌后，对你的英雄造成1点伤害并获得+2+1")
