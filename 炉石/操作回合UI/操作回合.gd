extends Control
class_name OperationUI

@export var player:PlayerEntity

signal 使用卡牌信号(使用的卡片:CardUI)

@onready var 酒馆:=$"PanelContainer/HBoxContainer/VBoxContainer/酒馆/酒馆拖拽"
@onready var 战场:=$"PanelContainer/HBoxContainer/VBoxContainer/战场/战场拖拽"
@onready var 手牌:=$"PanelContainer/HBoxContainer/VBoxContainer/手牌/手牌拖拽"
@onready var 箭头遮罩:=$"PanelContainer/箭头遮罩"
@onready var 抉择遮罩:=$"PanelContainer/抉择遮罩"

func 初始化(player:PlayerEntity):
	self.player=player
	player.添加卡牌信号.connect(_添加卡片.bind())
	player.删除卡牌信号.connect(_删除卡牌.bind())
	# UI初始化
	酒馆
	pass

func _process(delta: float) -> void:
	if player:
		
		pass

func _检查并更新酒馆():
	#if player:
		#var 是否重置=false
		#var luShiCard:Array[LuShiCard]=酒馆.获取所有的拖拽象().filter(func(node): return node is LuShiCard)
		#for i in luShiCard.size():
			#if luShiCard.get(i).cardEntity!=player.酒馆.get(i):
				#pass
	pass

func _删除卡牌(d:CardEntity,cardPosition:Enums.CardPosition):
	if cardPosition==Enums.CardPosition.酒馆:
		酒馆.erase(d)
		return
	if cardPosition==Enums.CardPosition.手牌:
		手牌.erase(d)
		return
	if cardPosition==Enums.CardPosition.战场:
		战场.erase(d)
		return
	printerr("错误删除卡牌卡片",d,cardPosition)
	print_stack()
	pass


## 由信号触发，不建议直接调用
func _添加卡片(d:CardEntity,cardPosition:Enums.CardPosition,index:int):
	var cardUI=CardUI.build(d,player)
	if cardPosition==Enums.CardPosition.酒馆:
		酒馆.添加到本容器中(cardUI)
		return
	if cardPosition==Enums.CardPosition.手牌:
		手牌.添加到本容器中(cardUI)
		return
	if cardPosition==Enums.CardPosition.战场:
		战场.添加到本容器中(cardUI)
		return
	printerr("错误添加卡片",cardUI,cardPosition)
	print_stack()
	pass

func _on_结束回合_pressed() -> void:
	# 将当前数据存储
	#var path="res://fight_ai/%s"%回合数
	var path="res://fight_ai/1"
	DirAccess.make_dir_absolute(path)
	var save=FileAccess.open(path+"/test.save",FileAccess.WRITE)
	save.store_var(self,true)
	pass # Replace with function body.


func _on_加载存档_pressed() -> void:
	var path="res://fight_ai/1"
	DirAccess.make_dir_absolute(path)
	var save=FileAccess.open(path+"/test.save",FileAccess.READ)
	var obj=save.get_var(true)
	get_parent().add_child(obj)
	pass # Replace with function body.
