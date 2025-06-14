extends Control
class_name DragCard

@onready var label:=$Label
var 是否为拖拽箭头:bool=true
var 是否箭头可以指向自己:bool=false
var _is_draging:bool=false
var _drag_offset

signal 拖拽开始
signal 拖拽结束

var 原有样式

func _ready() -> void:
	position=$"Node2D/遮罩".position
	原有样式=$Panel.get_theme_stylebox("panel") as StyleBoxFlat
	pass

func _process(delta: float) -> void:
	$Panel.size=size
	if _is_draging:
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			_is_draging=false
			if 是否为拖拽箭头:
				print("没用代码")
				# 是否存在目标
				#if 全局属性.箭头相关属性.箭头的结束节点:
					#print("对xx进行释放")
					#全局属性.箭头相关属性.箭头的结束节点.样式恢复()
					#全局属性.箭头相关属性.箭头的结束节点=false
				#全局属性.箭头相关属性.是否有拖拽箭头=false
				#样式恢复()
			else:
				#print("拖拽结束")
				拖拽结束.emit()
		if 是否为拖拽箭头:
			pass
		else:
			global_position= get_global_mouse_position()+_drag_offset

func 箭头被作为目标样式():
	var style = $Panel.get_theme_stylebox("panel").duplicate() as StyleBoxFlat
	style.bg_color=Color(0.753, 0.169, 0.059, 0.6)
	$Panel.add_theme_stylebox_override("panel",style)
	$"Node2D/箭头选中".show()
	pass

func 箭头启动样式():
	var style = $Panel.get_theme_stylebox("panel").duplicate() as StyleBoxFlat
	style.bg_color=Color(0.753, 0.569, 0.059, 0.6)
	$Panel.add_theme_stylebox_override("panel",style)
	$"Node2D/当前操作".show()
	pass

func 样式恢复():
	$Panel.add_theme_stylebox_override("panel",原有样式)
	for i in [$"Node2D/箭头选中",$"Node2D/当前操作"]:
		i.hide()
	pass

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT :
			_drag_offset = global_position-get_global_mouse_position()
			_is_draging=event.is_pressed()
			if _is_draging:
				if 是否为拖拽箭头:
					箭头启动样式()
					var l=Label.new()
					add_child(l)
					l.position=DisplayServer.mouse_get_position()
					全局属性.箭头相关属性.是否有拖拽箭头=true
					全局属性.箭头相关属性.箭头初始位置=get_global_mouse_position()
					全局属性.箭头相关属性.箭头的初始节点=self
				else:
					#print("拖拽开始")
					拖拽开始.emit()
				pass
			else:
				print("是否为拖拽箭头",是否为拖拽箭头)
				if 是否为拖拽箭头:
					if 全局属性.箭头相关属性.箭头的结束节点:
						print("对xx进行释放")
						全局属性.箭头相关属性.箭头的结束节点.样式恢复()
						全局属性.箭头相关属性.箭头的结束节点=false
					全局属性.箭头相关属性.是否有拖拽箭头=false
					样式恢复()
				else:
					#print("拖拽结束")
					拖拽结束.emit()
				pass
	pass # Replace with function body.


func _on_mouse_entered() -> void:
	if 全局属性:
		if 全局属性.箭头相关属性.是否有拖拽箭头:
			if 全局属性.箭头相关属性.箭头的初始节点==self:
				if !是否箭头可以指向自己:
					return
			箭头被作为目标样式()
			全局属性.箭头相关属性.箭头的结束节点=self
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	if 全局属性:
		if 全局属性.箭头相关属性.是否有拖拽箭头:
			if 全局属性.箭头相关属性.箭头的初始节点==self:
				if !是否箭头可以指向自己:
					return
			#print("我不作为目标了")
			样式恢复()
			全局属性.箭头相关属性.箭头的结束节点=null
	pass # Replace with function body.
 
