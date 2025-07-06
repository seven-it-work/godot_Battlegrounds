extends CardData

func 使用触发():
	super.使用触发()
	var list=_获取酒馆中的随从(player)
	if list.is_empty():
		return
	var 获取的牌=list.pick_random()
	获取的牌.card_data.is_gold=true
		
func _获取酒馆中的随从(player:Player)->Array:
	return player.酒馆.获取所有节点().filter(func(card:CardData): return card.card_data.cardType==Enums.CardTypeEnum.MINION and !card.card_data.is_gold)

func 是否能够使用()->bool:
	return !_获取酒馆中的随从(player).is_empty()
