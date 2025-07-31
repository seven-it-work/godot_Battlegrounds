extends PanelContainer
class_name ChooseOption

var 选项卡片:LuShiCard
signal 点击信号

func 初始化(card:LuShiCard):
	print("初始化选项")
	选项卡片=card
	$Label.text=card.名称
	pass

func 取消选中():
	var style=get_theme_stylebox("panel") as StyleBoxFlat
	style.border_color=Color(0.8, 0.8, 0.8)
	add_theme_stylebox_override("panel",style)
	
func 选中():
	var style=get_theme_stylebox("panel") as StyleBoxFlat
	style.border_color=Color(0.97, 0.775, 0.0)
	add_theme_stylebox_override("panel",style)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				点击信号.emit()
	pass # Replace with function body.
