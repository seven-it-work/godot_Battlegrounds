extends CardData

func 使用触发(player:Player):
	super.使用触发(player)
	if $"使用时是否需要选择目标".目标对象:
		# 如果目标存在类型
		var cardData= $"使用时是否需要选择目标".目标对象.card_data as CardData
		# todo这里的消灭可能存在bug，如果有圣盾则无法消灭，改为直接消灭方法
		cardData.hp_process(get_parent(),-cardData.hp_bonus(player),player)
		var 属性=get_AttributeBonus()
		属性.atk=cardData.lv
		player.亡灵加成.append(属性)
		
func 是否能够使用(player:Player)->bool:
	return !$"使用时是否需要选择目标".筛选方法(player.战场.获取所有节点()).is_empty()

func 筛选方法(list:Array)->Array:
	return list.filter(func(card:CardData): return card.card_data.所在位置==Enums.CardPosition.战场 and card.card_data.是否属于种族(Enums.RaceEnum.UNDEAD))
