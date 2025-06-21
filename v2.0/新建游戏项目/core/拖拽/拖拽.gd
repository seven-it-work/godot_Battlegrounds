extends Control
class_name DragControl

@export var 是否可以拖拽:bool=true
@export var 容器中是否可以拖拽:bool=true
@export var card_data:CardData
@onready var label=$Label
var 是否按下拖拽:bool=false
var _drag_offset

signal 开始拖拽
signal 结束拖拽

func 是否可以拖拽判断()->bool:
	return 是否可以拖拽 and 容器中是否可以拖拽

func _process(delta: float) -> void:
	custom_minimum_size=$Panel.size
	var 链接=get_signal_connection_list("结束拖拽")
	if card_data:
		label.text=card_data.name_str
	#var temptext=""
	#for i in 链接:
		#var path=i.callable as Callable
		#var obj=path.get_object()
		#temptext+=obj.name_str+"\n"
	#$Label.text="%s"%temptext
	if 是否可以拖拽判断():
		if 是否按下拖拽:
			if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				释放()
			拖拽中处理()
	pass

func 拖拽中处理():
	global_position=get_global_mouse_position()+_drag_offset
	

func 释放():
	if 是否按下拖拽:
		#print("释放")
		是否按下拖拽=false
		结束拖拽.emit()

func _on_panel_gui_input(event: InputEvent) -> void:
	if 是否可以拖拽判断():
		if event is InputEventMouseButton:
			var eventMouse=event as InputEventMouseButton
			if eventMouse.button_index==MOUSE_BUTTON_LEFT:
				if eventMouse.is_pressed():
					#print("按下")
					_drag_offset = global_position-get_global_mouse_position()
					是否按下拖拽=true
					开始拖拽.emit()
				else:
					释放()
