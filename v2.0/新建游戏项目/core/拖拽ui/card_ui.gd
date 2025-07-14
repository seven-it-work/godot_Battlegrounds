extends Control

class_name CardUI

signal 点击()
signal 开始拖拽()
signal 结束拖拽()

var _drag_offset
var 是否按下拖拽:bool=false
var 是否能拖拽:bool=true

func 判断是否能拖拽()->bool:
	return 是否能拖拽

func _process(delta: float) -> void:
	$Panel.size=size
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_end_drag()
	if 是否按下拖拽:
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
	if event is InputEventMouseButton:
		var eventMouse=event as InputEventMouseButton
		if eventMouse.button_index==MOUSE_BUTTON_LEFT:
			if eventMouse.is_pressed():
				点击.emit()
				if 是否能拖拽:
					_start_drag()
			else:
				if 是否能拖拽:
					_end_drag()

func 改变样式(type:String=""):
	var style=$Panel.get_theme_stylebox("panel") as StyleBoxFlat
	if type=="选择目标":
		style.bg_color=Color(0.772, 0.558, 0.049)
		$Panel.add_theme_stylebox_override("panel",style)
		return
	if type=="提示卡片":
		style.bg_color=Color(0.382, 0.583, 1.0)
		$Panel.add_theme_stylebox_override("panel",style)
		return
	style.bg_color=Color(0.6, 0.6, 0.6, 0.0)
	$Panel.add_theme_stylebox_override("panel",style)
