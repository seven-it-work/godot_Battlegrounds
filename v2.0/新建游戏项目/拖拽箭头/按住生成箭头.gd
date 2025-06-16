extends Control

func _process(delta: float) -> void:
	if $"箭头".visible:
		$"箭头".update_curve(position,get_global_mouse_position())
	pass

func _on_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton :
		var eventMouse=event as InputEventMouseButton
		if eventMouse.button_index==MOUSE_BUTTON_LEFT:
			if eventMouse.is_pressed():
				print("按下")
				$"箭头".show()
			else:
				print("释放")
				$"箭头".hide()
