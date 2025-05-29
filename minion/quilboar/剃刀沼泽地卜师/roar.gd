extends Roar

func 战吼(触发者:BaseCard,player:Player,目标对象:BaseCard):
	player.add_card_in_handler(preload("uid://c84v1i3ulob37").instantiate())
	pass
