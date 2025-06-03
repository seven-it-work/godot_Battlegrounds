extends Roar
func 战吼(触发者:BaseCard,player:Player,目标对象:BaseCard):
	for i in 2 if 触发者.is_gold else 1:
		player.add_card_in_handler(preload("uid://dxxgwlqr5y8nt").instantiate())
	pass
