extends Node
class_name TargetSelector

@export var 是否需要选择目标:bool=true
@export var 是否必须选中目标:bool=false
var 目标对象:Card=null

func 筛选方法(list:Array[CardUI])->Array[CardUI]:
	print("默认的筛选方法")
	return list

func 是否能够作为目标(card:CardUI)->bool:
	# 默认是随从
	var card_data=card.card_data as CardData
	var 是否为随从=card_data.cardType==Enums.CardTypeEnum.MINION
	var 是否在酒馆或者战场=(card_data.所在位置==Enums.CardPosition.酒馆 or card_data.所在位置==Enums.CardPosition.战场)
	return 是否为随从 and 是否在酒馆或者战场
