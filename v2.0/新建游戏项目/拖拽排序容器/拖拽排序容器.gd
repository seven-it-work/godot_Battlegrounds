extends Control
class_name DragSortContainer2

@export var 插槽:DragSlot=preload("uid://uo2gx7wimlt8").instantiate()

var 拖拽时原有索引:int=0
var 拖拽中的节点

func _process(delta: float) -> void:
	$HBoxContainer.size=size
	if 拖拽中的节点:
		动态更新插槽()

func 删除(拖拽节点:DragControl):
	pass

func 添加到容器中(拖拽节点:DragControl,index:int=-1):
	if 拖拽节点.get_parent():
		拖拽节点.reparent($HBoxContainer)
	else:
		$HBoxContainer.add_child(拖拽节点)
	新建信号(拖拽节点)
	$HBoxContainer.move_child(拖拽节点,index)
	await  get_tree().process_frame
	pass

func 初始化插槽():
	var list=$HBoxContainer.get_children()
	for index in list.size()+1:
		var temp插槽=插槽.duplicate()
		temp插槽.size=拖拽中的节点.size
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

func 获取插槽():
	return $HBoxContainer.get_children().filter(func(x): return x is DragSlot)

func 动态更新插槽():
	var mp = get_global_mouse_position()
	var height = 拖拽中的节点.size.x*0.5
	## 拖拽时 插槽的动画时间
	var place_holder_duration :float = 0.2
	for holder in 获取插槽():
		var 扩展宽度=拖拽中的节点.size.x/2
		var rect = holder.get_global_rect().grow_individual(扩展宽度,0,扩展宽度,0)
		if rect.has_point(mp):
			if not holder.active:
				holder.active = true
				holder.change_size(拖拽中的节点.size*0.8, place_holder_duration)
		else:
			if holder.active:
				holder.active = false
				holder.change_size(Vector2(4,size.y), place_holder_duration)
				

func 回到原来位置():
	print("回归原位置")
	拖拽中的节点.reparent($HBoxContainer)
	$HBoxContainer.move_child(拖拽中的节点, 拖拽时原有索引)
	

func 开始拖拽(拖拽节点):
	print("开始拖拽")
	拖拽中的节点=拖拽节点
	拖拽时原有索引=拖拽节点.get_index()
	拖拽节点.reparent(self)
	初始化插槽()
	pass

func _获取激活的插槽():
	var actives = 获取插槽().filter(func(x): return x.active)
	if actives:
		return actives[0].get_index()/2

func 结束拖拽(拖拽节点):
	print("结束拖拽")
	# 是否进入插槽中
	var 是否激活插槽=_获取激活的插槽()
	清理插槽()
	await get_tree().process_frame
	if 是否激活插槽==null:
		回到原来位置()
		拖拽中的节点=null
	else:
		拖拽中的节点.reparent($HBoxContainer)
		$HBoxContainer.move_child(拖拽中的节点, 是否激活插槽)
		拖拽中的节点=null
		return

func 进入区域(dragControl:DragControl,进入的区域:Control):
	print("进入区域")
	if 进入的区域.拖拽中的节点:
		pass
	else:
		进入的区域.拖拽中的节点=dragControl
		进入的区域.初始化插槽()
	进入的区域.拖拽中的节点=dragControl
	pass

func 离开区域(dragControl:DragControl,进入的区域:Control):
	print("离开区域")
	if 进入的区域.拖拽中的节点:
		pass
	else:
		进入的区域.清理插槽()
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
