extends Control
class_name PlayerOperationUI

#@onready var 战场:=$"战场" 
#@onready var 酒馆:=$"酒馆" 
#@onready var 手牌:=$"手牌"

func _ready() -> void:
	$"PanelContainer/VBoxContainer/酒馆/酒馆拖拽".添加到本容器中($"拖拽")
