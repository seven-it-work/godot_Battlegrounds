extends Control
class_name OperationUI

@export var player:Player
@onready var 酒馆:=$"PanelContainer/HBoxContainer/VBoxContainer/PanelContainer/酒馆"
@onready var 战场:=$"PanelContainer/HBoxContainer/VBoxContainer/PanelContainer2/战场"
@onready var 手牌:=$"PanelContainer/HBoxContainer/VBoxContainer/PanelContainer3/手牌"
@onready var 箭头遮罩:=$"PanelContainer/箭头遮罩"
@onready var 抉择遮罩:=$"PanelContainer/抉择遮罩"

func _process(delta: float) -> void:
	if player:
		$PanelContainer/HBoxContainer/Tips/VBoxContainer/Label.text=str(player.酒馆.size())
		$PanelContainer/HBoxContainer/Tips/VBoxContainer/Label2.text=str(player.战场.size())
		$PanelContainer/HBoxContainer/Tips/VBoxContainer/Label3.text=str(player.手牌.size())
	pass

func 初始化(player:Player):
	self.player=player
	self.player.添加卡片信号.connect(_添加卡片.bind())
	self.player.删除卡片信号.connect(_删除卡片.bind())
	
	_初始化容器(player,Enums.CardPosition.酒馆)
	_初始化容器(player,Enums.CardPosition.手牌)
	_初始化容器(player,Enums.CardPosition.战场)
	pass

func _初始化容器(player:Player,所在位置:Enums.CardPosition):
	var temp
	var card_list
	if 所在位置==Enums.CardPosition.酒馆:
		temp=酒馆
		card_list=player.酒馆
	elif 所在位置==Enums.CardPosition.手牌:
		temp=手牌
		card_list=player.手牌
	elif 所在位置==Enums.CardPosition.战场:
		temp=战场
		card_list=player.战场
	else:
		printerr("错误了")
		print_stack()
	temp.player=player
	for i in temp.容器.get_children():
		i.queue_free()
	for i:CardEntity in card_list:
		i.player=self.player
		i.信号绑定()
		_添加卡片(i,所在位置,-1)
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
	var cardUI
	if d.get_parent() is CardUI:
		cardUI=d.get_parent()
	else:
		cardUI=CardUI.build(d)
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
