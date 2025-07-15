extends PanelContainer
class_name  BackpackItem
@export var item:Item
signal 聚焦

func _process(delta: float) -> void:
	if item:
		var style=get_theme_stylebox("panel") as StyleBoxFlat
		style.bg_color=item.获取品阶对应颜色()
		add_theme_stylebox_override("panel",style)
		$Label.hide()
		$TextureRect.hide()
		if StrUtils.is_blank(item.texture_path):
			$Label.show()
			$Label.text=item.item_name
		else:
			$TextureRect.show()
			$TextureRect.texture=load(item.texture_path)
	pass


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event.is_pressed():
			聚焦.emit()
