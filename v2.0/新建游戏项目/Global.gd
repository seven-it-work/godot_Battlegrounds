extends Node

var main_node:Player
# key=文件名(也就是name_str) value=cardData
#var all_card:Dictionary=CardsUtils.scan_scenes_recursive("res://all_card/")
var all_card:Dictionary={}

func 获取原始版卡片(name_str:String)->CardData:
	if all_card.has(name_str):
		return all_card.get(name_str).duplicate()
	Logger.error("没有叫[%s]的卡片"%name_str)
	return null

func copyDragCard(dragCard:DragControl)->DragControl:
	var newNode=dragCard.duplicate() as DragControl
	newNode.card_data.player=dragCard.card_data.player
	return newNode

func 创建新卡片(cardData:CardData,player:Player)->DragControl:
	var drag=preload("uid://do8ek6iw7tisd").instantiate()
	cardData.player=player
	drag.card_data=cardData
	drag.add_child(cardData)
	return drag
