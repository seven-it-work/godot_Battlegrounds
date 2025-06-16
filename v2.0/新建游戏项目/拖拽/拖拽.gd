extends Control
class_name DragControl

@export var 区域:Array[Control]=[]
var 是否按下拖拽:bool=false
var _drag_offset

signal 开始拖拽
signal 结束拖拽
signal 进入区域(dragControl:DragControl,进入的区域:Control)

func _process(delta: float) -> void:
	custom_minimum_size=$Panel.size
	if 是否按下拖拽:
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			释放()
		global_position=get_global_mouse_position()+_drag_offset
	pass

func 释放():
	print("释放")
	是否按下拖拽=false
	结束拖拽.emit()
	# 判断是否进入区域，进入的话提交进入区域信号
	for i in 区域:
		if i.get_global_rect().has_point(get_global_mouse_position()):
			进入区域.emit(self,i)
	pass

func _on_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var eventMouse=event as InputEventMouseButton
		if eventMouse.button_index==MOUSE_BUTTON_LEFT:
			if eventMouse.is_pressed():
				print("按下")
				_drag_offset = global_position-get_global_mouse_position()
				是否按下拖拽=true
				开始拖拽.emit()
			else:
				释放()
