extends Roar


func 战吼(触发者:BaseCard,player:Player,目标对象:BaseCard):
	var card=preload("uid://s021h17wdor7").instantiate()
	card.atk=1
	card.is_gold=触发者.is_gold
	player.召唤随从到战场(card,触发者.get_parent().get_index()+1)
	pass
