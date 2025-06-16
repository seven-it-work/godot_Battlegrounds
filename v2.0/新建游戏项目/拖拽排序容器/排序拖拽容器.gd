extends DragContainer
class_name DragSortContainer

@export var 插槽:DragSlot=preload("uid://uo2gx7wimlt8").instantiate()

func _process(delta: float) -> void:
	super._process(delta)
	if 拖拽中的节点:
		动态更新插槽()


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


func 开始拖拽(拖拽节点):
	super.开始拖拽(拖拽节点)
	初始化插槽()


func 结束拖拽(拖拽节点:DragControl):
	拖拽中的节点=拖拽节点
	var 是否激活插槽=_获取激活的插槽()
	清理插槽()
	await get_tree().process_frame
	if 是否激活插槽==null:
		if 拖拽节点.进入的区域:
			if 拖拽节点.进入的区域 is DragSortContainer:
				是否激活插槽=拖拽节点.进入的区域._获取激活的插槽()
				if 是否激活插槽==null:
					回到原来位置()
				else:
					断开信号(拖拽节点)
					拖拽节点.区域.erase(拖拽节点.进入的区域)
					拖拽节点.进入的区域.清理插槽()
					await get_tree().process_frame
					拖拽节点.进入的区域.添加到容器中(拖拽节点,是否激活插槽)
		else:
			回到原来位置()
	else:
		添加到容器中(拖拽节点,是否激活插槽)
	拖拽中的节点=null


func 进入区域(dragControl:DragControl,进入的区域:Control):
	super.进入区域(dragControl,进入的区域)
	if 进入的区域 is DragSortContainer:
		进入的区域.初始化插槽()
		pass
	pass

func 离开区域(dragControl:DragControl,进入的区域:Control):
	super.离开区域(dragControl,进入的区域)
	if 进入的区域 is DragSortContainer:
		进入的区域.清理插槽()
		pass

func _获取激活的插槽():
	var actives = 获取插槽().filter(func(x): return x.active)
	if actives:
		return actives[0].get_index()/2

func 获取插槽():
	return $HBoxContainer.get_children().filter(func(x): return x is DragSlot)

func 清理插槽():
	for child in $HBoxContainer.get_children():
		if child is DragSlot:
			child.queue_free()
