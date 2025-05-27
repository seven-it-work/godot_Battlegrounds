extends BaseDragableCard


func _ready():
	#drag_handle_texture_rect.button_down.connect(start_drag)
	pass

func _gui_input(event: InputEvent) -> void:
	# 拖拽触发场景
	if event is InputEventMouse:
		if event.is_pressed() and event.button_mask==MOUSE_BUTTON_LEFT:
			start_drag()
