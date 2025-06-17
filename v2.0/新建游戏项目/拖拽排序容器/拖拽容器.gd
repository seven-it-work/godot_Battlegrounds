extends Control
class_name DragContainer


var 拖拽时原有索引:int=-1
var 拖拽中的节点
# 可以拖入的容器
@export var 区域:Array[Control]=[]

signal 进入容器并释放(拖拽:DragControl,进入的容器:Control)


func _process(delta: float) -> void:
	$HBoxContainer.size=size
	$Panel.size=size

func 删除(拖拽节点:DragControl):
	拖拽节点.区域=拖拽节点.区域.filter(func(area): return !区域.has(area))

func 添加到容器中(拖拽节点:DragControl,index):
	print("添加节点")
	拖拽节点.区域=区域
	if 拖拽节点.get_parent():
		if 拖拽节点.get_parent() is DragContainer:
			拖拽节点.get_parent().断开信号(拖拽节点)
		拖拽节点.reparent($HBoxContainer)
	else:
		$HBoxContainer.add_child(拖拽节点)
	新建信号(拖拽节点)
	$HBoxContainer.move_child(拖拽节点,index)
	await get_tree().process_frame
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
	print("结束拖拽了")
	if 拖拽节点.进入的区域:
		进入容器并释放.emit(拖拽节点,拖拽节点.进入的区域)
		if 拖拽节点.进入的区域:
			# 这里再次判断是 进入容器并释放 这里的操作给弄掉了 弄掉了标识信号 以及处理完了
			if 拖拽节点.进入的区域 is DragSortContainer:
				拖拽节点.进入的区域.从其他容器中拖入排序()
			elif 拖拽节点.进入的区域 is DragContainer:
				print("在DragContainer结束拖拽了")
				拖拽节点.进入的区域.添加到容器中(拖拽节点,-1)
				拖拽节点.进入的区域.拖拽中的节点=null
	else:
		回到原来位置()
		拖拽中的节点=null

func 进入区域(dragControl:DragControl,进入的区域:Control):
	if 进入的区域.拖拽中的节点:
		return
	if 进入的区域 is DragContainer:
		print("进入区域")
		if 进入的区域.拖拽中的节点:
			pass
		else:
			进入的区域.拖拽中的节点=dragControl
		进入的区域.拖拽中的节点=dragControl
	if 进入的区域 is DragSortContainer:
		进入的区域.初始化插槽()
		pass
	pass

func 离开区域(dragControl:DragControl,进入的区域:Control):
	print("离开区域")
	if 进入的区域.拖拽中的节点:
		pass
	else:
		pass
	进入的区域.拖拽中的节点=null
	if 进入的区域 is DragSortContainer:
		进入的区域.清理插槽()
		pass
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
