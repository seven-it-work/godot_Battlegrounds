extends Control
class_name DragContainer


var 拖拽时原有索引:int=-1
var 拖拽中的节点


func _process(delta: float) -> void:
	$HBoxContainer.size=size

func 删除(拖拽节点:DragControl):
	pass

func 添加到容器中(拖拽节点:DragControl,index):
	if 拖拽节点.get_parent():
		if 拖拽节点.get_parent() is DragContainer:
			拖拽节点.get_parent().断开信号(拖拽节点)
		拖拽节点.reparent($HBoxContainer)
	else:
		$HBoxContainer.add_child(拖拽节点)
	新建信号(拖拽节点)
	$HBoxContainer.move_child(拖拽节点,index)
	await  get_tree().process_frame
	pass

func 回到原来位置():
	print("回归原位置")
	拖拽中的节点.reparent($HBoxContainer)
	$HBoxContainer.move_child(拖拽中的节点, 拖拽时原有索引)
	

func 开始拖拽(拖拽节点):
	print("开始拖拽")
	拖拽中的节点=拖拽节点
	拖拽时原有索引=拖拽节点.get_index()
	拖拽节点.reparent(self)
	pass


func 结束拖拽(拖拽节点:DragControl):
	if 拖拽节点.进入的区域:
		if 拖拽节点.进入的区域 is DragContainer:
			拖拽节点.进入的区域.添加到容器中(拖拽节点,-1)
	else:
		回到原来位置()
	拖拽中的节点=null

func 进入区域(dragControl:DragControl,进入的区域:Control):
	if 进入的区域 is DragContainer:
		print("进入区域")
		if 进入的区域.拖拽中的节点:
			pass
		else:
			进入的区域.拖拽中的节点=dragControl
		进入的区域.拖拽中的节点=dragControl
	pass

func 离开区域(dragControl:DragControl,进入的区域:Control):
	print("离开区域")
	if 进入的区域.拖拽中的节点:
		pass
	else:
		pass
	进入的区域.拖拽中的节点=null
	pass

func 新建信号(拖拽节点):
	拖拽节点.开始拖拽.connect(开始拖拽.bind(拖拽节点))
	拖拽节点.结束拖拽.connect(结束拖拽.bind(拖拽节点))
	拖拽节点.进入区域.connect(进入区域.bind())
	拖拽节点.离开区域.connect(离开区域.bind())

func 断开信号(拖拽节点:DragControl):
	if 拖拽节点.开始拖拽.is_connected(开始拖拽):
		拖拽节点.开始拖拽.disconnect(开始拖拽)
	if 拖拽节点.结束拖拽.is_connected(结束拖拽):
		拖拽节点.结束拖拽.disconnect(结束拖拽)
	if 拖拽节点.进入区域.is_connected(进入区域):
		拖拽节点.进入区域.disconnect(进入区域)
	if 拖拽节点.离开区域.is_connected(离开区域):
		拖拽节点.离开区域.disconnect(离开区域)
