extends Control
class_name PlayerOperationUI

static var 操作回合:PlayerOperationUI


@onready var 酒馆:=$"PanelContainer/HBoxContainer/VBoxContainer/酒馆/酒馆拖拽"
@onready var 战场:=$"PanelContainer/HBoxContainer/VBoxContainer/战场/战场拖拽"
@onready var 手牌:=$"PanelContainer/HBoxContainer/VBoxContainer/手牌/手牌拖拽"
@onready var 箭头遮罩:=$"PanelContainer/箭头遮罩"
@onready var 抉择遮罩:=$"PanelContainer/抉择遮罩"
@export var player:Player

func 获取酒馆And战场的牌()->Array[LuShiCard]:
	var result:Array[LuShiCard]=[]
	for i in 酒馆.获取所有的拖拽象():
		if i is LuShiCard:
			result.append(i as LuShiCard)
	for i in 战场.获取所有的拖拽象():
		if i is LuShiCard:
			result.append(i as LuShiCard)
	return result

func _ready() -> void:
	操作回合=self
	添加卡片(preload("uid://cgag5xssn8n0a").instantiate(),Enums.CardPosition.酒馆)
	添加卡片(preload("uid://cgag5xssn8n0a").instantiate(),Enums.CardPosition.酒馆)


func 添加卡片(d:LuShiCard,cardPosition:Enums.CardPosition):
	d.信号绑定方法(player)
	if cardPosition==Enums.CardPosition.酒馆:
		酒馆.添加到本容器中(d)
		return
	if cardPosition==Enums.CardPosition.手牌:
		手牌.添加到本容器中(d)
		return
	if cardPosition==Enums.CardPosition.战场:
		战场.添加到本容器中(d)
		return
	printerr("错误添加卡片",d,cardPosition)
	print_stack()
