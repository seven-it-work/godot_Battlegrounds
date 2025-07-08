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
	return card_data.cardType==Enums.CardTypeEnum.MINION
