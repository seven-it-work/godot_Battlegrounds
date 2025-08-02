extends Control
class_name OperationUI

@export var player:Player
@onready var 酒馆:=$"PanelContainer/HBoxContainer/VBoxContainer/PanelContainer/酒馆"
@onready var 战场:=$"PanelContainer/HBoxContainer/VBoxContainer/PanelContainer2/战场"
@onready var 手牌:=$"PanelContainer/HBoxContainer/VBoxContainer/PanelContainer3/手牌"
@onready var 箭头遮罩:=$"PanelContainer/箭头遮罩"
@onready var 抉择遮罩:=$"PanelContainer/抉择遮罩"


func 初始化(player:Player):
	self.player=player
	self.player.添加卡片信号.connect(_添加卡片.bind())
	self.player.删除卡片信号.connect(_删除卡片.bind())
	
	初始化容器(player,酒馆)
	初始化容器(player,战场)
	初始化容器(player,手牌)
	pass

func 初始化容器(player:Player,dragObjContainer:DragObjContainer):
	dragObjContainer.player=player
	for i in dragObjContainer.容器.get_children():
		i.queue_free()
	for i in player.酒馆:
		_添加卡片(i,Enums.CardPosition.酒馆,-1)
	pass

func _删除卡片(
	d:CardEntity,
	cardPosition:Enums.CardPosition,
):
	if cardPosition==Enums.CardPosition.酒馆:
		for i in 酒馆.获取所有的拖拽象():
			if i is CardUI:
				if i.cardData==d:
					i.queue_free()
		return
	if cardPosition==Enums.CardPosition.手牌:
		for i in 手牌.获取所有的拖拽象():
			if i is CardUI:
				if i.cardData==d:
					i.queue_free()
		return
	if cardPosition==Enums.CardPosition.战场:
		for i in 战场.获取所有的拖拽象():
			if i is CardUI:
				if i.cardData==d:
					i.queue_free()
		return
	printerr("错误删除卡片",d,cardPosition)
	print_stack()
	pass
	
	
func _添加卡片(
	d:CardEntity,
	cardPosition:Enums.CardPosition,
	index:int
):
	# 初始ui
	var cardUI=CardUI.build(d)
	if cardPosition==Enums.CardPosition.酒馆:
		酒馆.只添加到容器中(cardUI,index)
		return
	if cardPosition==Enums.CardPosition.手牌:
		手牌.只添加到容器中(cardUI,index)
		return
	if cardPosition==Enums.CardPosition.战场:
		战场.只添加到容器中(cardUI,index)
		return
	printerr("错误添加卡片",d,cardPosition)
	print_stack()
