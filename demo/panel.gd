extends Panel

var is_drag:bool=false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if is_drag:
		position=get_global_mouse_position()-size/2

func _on_mouse_entered() -> void:
	print("鼠标进入就高亮")
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	print("鼠标离开就取消高亮")
	pass # Replace with function body.


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		is_drag = event.pressed
	pass # Replace with function body.
