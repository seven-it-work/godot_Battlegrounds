extends PanelContainer
class_name ItemUI


var _是否为空格:bool=false
var 是否可以叠加:bool=true
var 叠加数量:int=1

signal 鼠标悬浮在当前物品
signal 鼠标离开在当前物品
signal 点击物品信号

@onready var 数量:=$"数量"

func _process(delta: float) -> void:
	if 数量:
		if 是否可以叠加:
			if 叠加数量>1:
				if !数量.visible:
					数量.show()
				数量.get_child(0).text=str(叠加数量)
	pass

#region 子类可以实现
func 判断是否为同一物品(itemUI:ItemUI)->bool:
	return true

func 获取物品数据():
	return self

func 选中样式更改(type:String):
	if type=="选中":
		var style=get_theme_stylebox("panel") as StyleBoxFlat
		style.border_color=Color(0.983, 0.769, 0.0)
		add_theme_stylebox_override("panel",style)
		return
		
	if type=="取消选中":
		var style=get_theme_stylebox("panel") as StyleBoxFlat
		style.border_color=Color(0.8, 0.8, 0.8)
		add_theme_stylebox_override("panel",style)
		return
	pass

#endregion

func _on_mouse_entered() -> void:
	鼠标悬浮在当前物品.emit()


func _on_mouse_exited() -> void:
	鼠标离开在当前物品.emit()
	pass # Replace with function body.

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				点击物品信号.emit()
			pass
	pass # Replace with function body.
