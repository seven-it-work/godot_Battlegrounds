extends Roar


func 战吼(触发者:BaseCard,player:Player,目标对象:BaseCard):
	var card=preload("uid://s021h17wdor7").instantiate()
	card.atk=1
	card.is_gold=触发者.is_gold
	player.add_card_in_bord(card)
	pass
