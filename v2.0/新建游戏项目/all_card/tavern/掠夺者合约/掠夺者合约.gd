extends CardData

func 使用触发():
	super.使用触发(player)
	var list=_获取酒馆中的海盗(player)
	if list.is_empty():
		return
	var 获取的牌=list.pick_random()
	player.添加到手牌(获取的牌)
		
func _获取酒馆中的海盗(player:Player)->Array:
	return player.酒馆.获取所有节点().filter(func(card:CardData): return card.card_data.是否属于种族(Enums.RaceEnum.PIRATE))

func 是否能够使用()->bool:
	return !_获取酒馆中的海盗(player).is_empty()
