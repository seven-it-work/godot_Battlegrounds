class_name Tavern extends Node2D
@export var lv:int=1;
# 酒馆中的随从
var current_card:Array[BaseCard]=[]
# 当前铸币
var current_coin:int=0;
# 最大铸币
var max_coin:int=0;


func get_all_minion()->Array[BaseCard]:
	return current_card.filter(func(card:BaseCard): return card.cardType==BaseCard.CardTypeEnum.MINION)
