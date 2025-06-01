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

func _find_minion_index(card:BaseCard)->int:
	return current_card.find_custom(card.uuid_eq.bind())

func buy_card(card:BaseCard)->int:
	var index=_find_minion_index(card)
	if index<0:
		printerr("酒馆移除失败")
		return -1
	current_card.remove_at(index)
	return index
