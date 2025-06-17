extends Control
class_name DragControl

@export var 区域:Array[Control]=[]

var 是否按下拖拽:bool=false
var _drag_offset
var 进入的区域:Control

signal 开始拖拽
signal 结束拖拽
signal 进入区域(dragControl:DragControl,进入的区域:Control)
signal 离开区域(dragControl:DragControl,进入的区域:Control)

func _process(delta: float) -> void:
	custom_minimum_size=$Panel.size
	if 是否按下拖拽:
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			释放()
		拖拽中处理()
		# 判断是否进入区域，进入的话提交进入区域信号
		if 进入的区域:
			if 进入的区域.get_global_rect().has_point(get_global_mouse_position()):
				# print("还在区域中")
				pass
			else:
				print("离开区域了")
				离开区域.emit(self,进入的区域)
				进入的区域=null
		else:
			for i in 区域:
				if i.get_global_rect().has_point(get_global_mouse_position()):
					print("进入区域了")
					进入区域.emit(self,i)
					if 进入的区域:
						print("已经存在进入区域了，又检测到进入其他区域 即将覆盖。注意！！！不建议区域直接存在重复位置")
					进入的区域=i
	pass

func 拖拽中处理():
	global_position=get_global_mouse_position()+_drag_offset
	

func 释放():
	if 是否按下拖拽:
		print("释放")
		是否按下拖拽=false
		结束拖拽.emit()
		进入的区域=null

func _on_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var eventMouse=event as InputEventMouseButton
		if eventMouse.button_index==MOUSE_BUTTON_LEFT:
			if eventMouse.is_pressed():
				print("按下")
				_drag_offset = global_position-get_global_mouse_position()
				是否按下拖拽=true
				开始拖拽.emit()
			else:
				释放()
