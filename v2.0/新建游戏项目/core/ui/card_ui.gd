extends Control

class_name CardUI

signal 开始拖拽()
signal 结束拖拽()

var _drag_offset
var 是否按下拖拽:bool=false
var 是否能拖拽:bool=true

func 判断是否能拖拽()->bool:
	return 是否能拖拽

func _process(delta: float) -> void:
	$Panel.size=size
	if 是否按下拖拽:
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			_end_drag()
		_draging()

func _draging():
	global_position=get_global_mouse_position()+_drag_offset

func _start_drag():
	_drag_offset = global_position-get_global_mouse_position()
	是否按下拖拽=true
	开始拖拽.emit()

func _end_drag():
	if 是否按下拖拽:
		是否按下拖拽=false
		结束拖拽.emit()


func _on_panel_gui_input(event: InputEvent) -> void:
	if !是否能拖拽:
		return
	if event is InputEventMouseButton:
		var eventMouse=event as InputEventMouseButton
		if eventMouse.button_index==MOUSE_BUTTON_LEFT:
			if eventMouse.is_pressed():
				_start_drag()
			else:
				_end_drag()
