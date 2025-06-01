extends Roar

func 战吼(触发者:BaseCard,player:Player,目标对象:BaseCard):
	player.add_card_in_bord(preload("uid://ccbl6jks6vaxj").instantiate())
