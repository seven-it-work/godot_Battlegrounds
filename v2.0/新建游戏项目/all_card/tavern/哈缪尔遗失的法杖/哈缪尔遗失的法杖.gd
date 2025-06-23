extends CardData

func 使用触发(player:Player):
	if $"使用时是否需要选择目标".目标对象:
		# 如果目标存在类型
		var cardData= $"使用时是否需要选择目标".目标对象.card_data as CardData
		# todo 刷新酒馆
		
