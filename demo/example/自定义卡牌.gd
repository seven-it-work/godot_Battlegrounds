extends BaseDragableCard

@onready var area1=$Area2D
func _ready():
	#drag_handle_texture_rect.button_down.connect(start_drag)
	pass

func _gui_input(event: InputEvent) -> void:
	# 拖拽触发场景
	if event is InputEventMouse:
		if event.is_pressed() and event.button_mask==MOUSE_BUTTON_LEFT:
			start_drag()

func 更新容器(容器:容器区域):
	print("更新容器")
	self.reparent(容器.cards)
	pass
