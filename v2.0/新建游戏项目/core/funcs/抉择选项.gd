extends PanelContainer
class_name ChooseOption

signal 选择信号(选项:ChooseOption)
@export var 描述:String=""

func get_desc(card:DragControl,player:Player,otherJson:Dictionary={})->String:
	var playerJson:Dictionary=JsonUtils.obj_2_json(player)
	playerJson.assign(otherJson)
	return StrUtils.自定义format(描述,playerJson)

func 执行方法(player:Player,card:DragControl):
	Logger.error("子类必须实现它，否则用哦")
	pass

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
