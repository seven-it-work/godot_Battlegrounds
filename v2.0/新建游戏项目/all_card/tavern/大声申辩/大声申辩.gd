extends CardData

func 使用触发():
	super.使用触发(player)
	if player.上一个对手:
		var list=player.上一个对手.战场.获取所有节点()
		if list.is_empty():
			# 空的无法获取
			return
		var card=list.pick_random() as CardData
		var temp=Global.获取原始版卡片(card.card_data.name_str)
		player.添加到手牌(temp)
		
		
