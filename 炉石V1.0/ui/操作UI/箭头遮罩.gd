extends Panel

@onready var 箭头:=$"箭头"
var 触发监听的卡片:CardUI
var 可以选择的卡片:Array[CardEntity]=[]
var 使用成功:Callable
var 取消:Callable

var _选中的卡片:CardUI

func 初始化(拖拽中的对象:CardUI,list:Array[CardEntity],使用成功:Callable,取消:Callable):
	self.触发监听的卡片=拖拽中的对象 as CardUI
	self.可以选择的卡片=list
	self.使用成功=使用成功
	self.取消=取消
	self.show()

func _process(delta: float) -> void:
	if visible and 触发监听的卡片:
		_选中的卡片=null
		for i in 可以选择的卡片:
			if i.get_parent().get_global_rect().has_point(get_global_mouse_position()):
				_选中的卡片=i.get_parent()
				i.get_parent().选中样式()
			else:
				i.get_parent().待选择样式()
		箭头.update_curve(触发监听的卡片.global_position+触发监听的卡片.size/2,get_global_mouse_position())


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				#print("点击了")
				if _选中的卡片:
					#print("选中了")
					触发监听的卡片.cardData.选择目标对象.目标卡片=_选中的卡片.cardData
					使用成功.call()
				else:
					取消.call()
					#print("未选中，取消使用了")
				# 清理操作
				for i in 可以选择的卡片:
					i.get_parent().原始样式()
				self.hide()
	pass # Replace with function body.
