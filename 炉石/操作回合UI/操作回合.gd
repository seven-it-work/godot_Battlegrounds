extends Control
class_name Player

signal 使用卡牌信号(使用的卡片:LuShiCard)

## 元素加成(攻击力/生命值)
@export var 元素加成:Vector2=Vector2(0,0)

@onready var 酒馆:=$"PanelContainer/HBoxContainer/VBoxContainer/酒馆/酒馆拖拽"
@onready var 战场:=$"PanelContainer/HBoxContainer/VBoxContainer/战场/战场拖拽"
@onready var 手牌:=$"PanelContainer/HBoxContainer/VBoxContainer/手牌/手牌拖拽"
@onready var 箭头遮罩:=$"PanelContainer/箭头遮罩"
@onready var 抉择遮罩:=$"PanelContainer/抉择遮罩"

func 获取酒馆And战场的牌()->Array[LuShiCard]:
	var result:Array[LuShiCard]=[]
	for i in 酒馆.获取所有的拖拽象():
		if i is LuShiCard:
			result.append(i as LuShiCard)
	for i in 战场.获取所有的拖拽象():
		if i is LuShiCard:
			result.append(i as LuShiCard)
	return result


func 添加卡片(d:LuShiCard,cardPosition:Enums.CardPosition):
	d.player=self
	d.信号绑定方法()
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
