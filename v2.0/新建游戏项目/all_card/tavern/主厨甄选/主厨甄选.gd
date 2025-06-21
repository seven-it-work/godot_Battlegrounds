extends CardData


func 使用触发(player:Player):
	if $"使用时是否需要选择目标".目标对象:
		print("todo 待开发主厨甄选或者种族类型相同的随从",$"使用时是否需要选择目标".目标对象.card_data.race)
	pass
