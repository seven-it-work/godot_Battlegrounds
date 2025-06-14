extends Control
class_name DragCard

@onready var label:=$Label
var 是否为拖拽箭头:bool=false
var _is_draging:bool=false
var _drag_offset

signal 拖拽开始
signal 拖拽结束

func _process(delta: float) -> void:
	if _is_draging:
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			_is_draging=false
			print("拖拽结束")
			拖拽结束.emit()
		global_position= get_global_mouse_position()+_drag_offset

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT :
			_drag_offset = global_position-get_global_mouse_position()
			_is_draging=event.is_pressed()
			if _is_draging:
				print("拖拽开始")
				拖拽开始.emit()
				pass
			else:
				print("拖拽结束")
				拖拽结束.emit()
				pass
	pass # Replace with function body.
