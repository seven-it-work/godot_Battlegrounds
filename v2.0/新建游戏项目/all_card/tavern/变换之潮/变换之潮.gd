extends CardData

func 使用触发(player:Player):
	super.使用触发(player)
	if $"使用时是否需要选择目标".目标对象:
		# 如果目标存在类型
		var cardData= $"使用时是否需要选择目标".目标对象.card_data as CardData
		cardData.atk_process(self.get_parent(),3,player)
		cardData.hp_process(self.get_parent(),3,player)
		if cardData.是否属于种族(Enums.RaceEnum.NAGA):
			cardData.atk_process(self.get_parent(),3,player)
			cardData.hp_process(self.get_parent(),3,player)
