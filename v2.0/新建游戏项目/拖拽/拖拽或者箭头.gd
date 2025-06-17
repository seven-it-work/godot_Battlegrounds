extends DragControl
class_name DragOrArrowControl

@export var 是否为箭头模式:bool=false
@export var 是否出现箭头:bool=false
@export var 箭头可以指向的区域:Array[Control]=[]

var 原来节点的区域:Array[Control]=[]

func 拖拽中处理():
	if 是否为箭头模式 or 是否出现箭头:
		$"箭头".update_curve(global_position,get_global_mouse_position()+_drag_offset)
	else:
		global_position=get_global_mouse_position()+_drag_offset


func _on_结束拖拽() -> void:
	if 是否为箭头模式 or 是否出现箭头:
		区域=原来节点的区域
		$"箭头".hide()
	pass # Replace with function body.


func _on_开始拖拽() -> void:
	if 是否为箭头模式 or 是否出现箭头:
		原来节点的区域=区域
		区域=箭头可以指向的区域
		$"箭头".show()
	pass # Replace with function body.
