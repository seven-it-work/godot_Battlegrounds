extends Control
class_name Backpack

@export var 背包大小:int=100;
@onready var 容器:=$ScrollContainer/VBoxContainer/GridContainer
@onready var tips:=$ScrollContainer/VBoxContainer/tips
func _ready() -> void:
	for i in 容器.get_children():
		i.queue_free()
	for i in 背包大小:
		var gezi=preload("uid://bcyi123vqud8w").instantiate()
		gezi.聚焦.connect(聚焦物品.bind(gezi))
		容器.add_child(gezi)
	pass

func 聚焦物品(格子:BackpackItem):
	tips.当前格子=格子
	pass
