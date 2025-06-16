extends Control
class_name DragContainer

@export var 插槽:DragSlot=preload("uid://uo2gx7wimlt8").instantiate()

var 拖拽时原有索引:int=0

func _process(delta: float) -> void:
	$HBoxContainer.size=size

func _ready() -> void:
	for i in 7 :
		var drag=preload("uid://c1wvxhubccoqe").instantiate()
		添加到容器中(drag)
	pass

func 添加到容器中(拖拽节点:DragControl,index:int=-1):
	if 拖拽节点.get_parent():
		拖拽节点.reparent($HBoxContainer)
	else:
		$HBoxContainer.add_child(拖拽节点)
	拖拽节点.开始拖拽.connect(开始拖拽.bind(拖拽节点))
	拖拽节点.结束拖拽.connect(结束拖拽.bind(拖拽节点))
	拖拽节点.进入区域.connect(进入区域.bind())
	$HBoxContainer.move_child(拖拽节点,index)
	await  get_tree().process_frame
	pass

func 初始化插槽():
	var list=$HBoxContainer.get_children()
	for index in list.size()+1:
		var temp插槽=插槽.duplicate()
		$HBoxContainer.add_child(temp插槽)
		$HBoxContainer.move_child(temp插槽, index*2)
		if index == 拖拽时原有索引:
			temp插槽.custom_minimum_size = temp插槽.size*0.8
		else:
			temp插槽.custom_minimum_size = Vector2(4,size.y)

func 清理插槽():
	for child in $HBoxContainer.get_children():
		if child is DragSlot:
			child.queue_free()
	pass
	
func 动态更新插槽():
	pass

func 开始拖拽(拖拽节点):
	print("开始拖拽")
	拖拽时原有索引=拖拽节点.get_index()
	拖拽节点.reparent(self)
	初始化插槽()
	pass

func 结束拖拽(拖拽节点):
	print("结束拖拽")
	清理插槽()
	pass

func 进入区域(dragControl:DragControl,进入的区域:Control):
	print("进入区域")
	pass


func 断开信号(拖拽节点:DragControl):
	if 拖拽节点.开始拖拽.is_connected(开始拖拽):
		拖拽节点.开始拖拽.disconnect(开始拖拽)
	if 拖拽节点.结束拖拽.is_connected(结束拖拽):
		拖拽节点.结束拖拽.disconnect(结束拖拽)
	if 拖拽节点.进入区域.is_connected(进入区域):
		拖拽节点.进入区域.disconnect(进入区域)
