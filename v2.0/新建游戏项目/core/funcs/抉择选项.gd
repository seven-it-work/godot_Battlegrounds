extends PanelContainer
class_name ChooseOption

signal 选择信号(选项:ChooseOption)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				选择信号.emit(self)


func 样式选中():
	var style=get_theme_stylebox("panel") as StyleBoxFlat
	style.border_color=Color(0.951, 0.785, 0.0)
	add_theme_stylebox_override("panel",style)
	pass


func 清理选中样式():
	var style=get_theme_stylebox("panel") as StyleBoxFlat
	style.border_color=Color(0.8, 0.8, 0.8)
	add_theme_stylebox_override("panel",style)
	pass
