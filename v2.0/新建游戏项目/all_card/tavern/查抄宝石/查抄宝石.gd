extends CardData

func 使用触发(player:Player):
	super.使用触发(player)
	if $"使用时是否需要选择目标".目标对象:
		# 如果目标存在类型
		var cardData= $"使用时是否需要选择目标".目标对象.card_data as CardData
		# 对一个cardData使用2张<b>鲜血宝石</b>并使其偷取相邻随从的所有<b>鲜血宝石</b>。
		
func 是否能够使用(player:Player)->bool:
	return !$"使用时是否需要选择目标".筛选方法(player.战场.获取所有节点()).is_empty()

func 筛选方法(list:Array)->Array:
	return list.filter(func(card:CardData): return card.card_data.所在位置==Enums.CardPosition.战场)
