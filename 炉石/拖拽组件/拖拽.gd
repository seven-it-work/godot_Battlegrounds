extends Control
class_name DragObj

signal 开始拖拽
signal 拖拽中
signal 结束拖拽

# 空闲\拖拽
var 当前状态:String="空闲"
var _drag_offset:Vector2

func _process(delta: float) -> void:
	if 当前状态=="拖拽":
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			拖拽中.emit()
			global_position= get_global_mouse_position()+_drag_offset
		else:
			当前状态="空闲"
			结束拖拽.emit()

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT:
			当前状态="拖拽"
			开始拖拽.emit()
			_drag_offset = global_position-get_global_mouse_position()
			pass
	pass # Replace with function body.


func _to_string() -> String:
	return "objectId=%s,name=%s,path=%s,json=%s"%[self.get_instance_id(),name,get_path(),JSON.stringify(ObjectUtils.get_exported_properties(self))]
