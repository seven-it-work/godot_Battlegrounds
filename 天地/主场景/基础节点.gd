extends Node2D
class_name BaseMainNode
@export var name_str:String=""
@onready var 节点额外操作:=$"节点额外操作"
@onready var 节点名称:=$"节点名称"

func _process(delta: float) -> void:
	节点名称.text=name_str
	pass
	
