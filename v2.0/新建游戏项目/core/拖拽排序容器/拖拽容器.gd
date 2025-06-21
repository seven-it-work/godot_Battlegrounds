extends Control
class_name DragContainer

@export var 是否可以排序:bool=false
@export var 是否可以拖拽:bool=true
@export var 排序的插槽:DragSlot=preload("uid://uo2gx7wimlt8").instantiate()
@export var name_str:String=""

var 拖拽时原有索引:int=-1
var 拖拽中的节点
# 可以拖入的容器
@export var 区域:Array[DragContainer]=[]

var 进入区域:DragContainer=null
var 其他区域来的节点

signal 进入容器信号(拖拽:DragControl,进入的容器:DragContainer)
signal 离开容器信号(拖拽:DragControl,离开的容器:DragContainer)
signal 在其他容器中释放信号(拖拽:DragControl,其他容器:DragContainer)


func _process(delta: float) -> void:
	$HBoxContainer.size=size
	$Panel.size=size
	if 是否可以拖拽:
		if 其他区域来的节点:
			if 是否可以排序:
				动态更新插槽(其他区域来的节点)
		if 拖拽中的节点:
			if 是否可以排序:
				动态更新插槽(拖拽中的节点)
			if 进入区域:
				if 进入区域.get_global_rect().has_point(get_global_mouse_position()):
					# 仍然在区域中
					pass
				else:
					# 离开区域
					#print(name_str,"离开区域")
					离开容器信号.emit(拖拽中的节点,进入区域)
					进入区域.节点退出区域(拖拽中的节点)
					进入区域=null
			else:
				for i in 区域:
					if i.get_global_rect().has_point(get_global_mouse_position()):
						#print(name_str,"进入区域")
						进入区域=i
						进入容器信号.emit(拖拽中的节点,进入区域)
						进入区域.节点进入区域(拖拽中的节点)

func 进入的区域进行释放(节点:DragControl):
	Logger.debug("进入的区域进行释放")
	#print(name_str,"进入的区域进行释放")
	if 其他区域来的节点!=节点:
		#print("可能出错了，需要定位分析")
		其他区域来的节点=节点
	var 激活的索引=_获取激活的插槽()
	if !获取插槽().is_empty():
		清理插槽()
		await get_tree().process_frame
	if 是否可以排序:
		#print(name_str,"排序插槽")
		if 激活的索引==null:
			#print("排序 没有激活 追加到最后")
			添加到容器中(节点,-1)
		else:
			添加到容器中(节点,激活的索引)
	else:
		#print("不可排序 追加到最后")
		添加到容器中(节点,-1)
	其他区域来的节点=null
	pass

func 节点进入区域(节点:DragControl):
	#print(name_str,"节点进入容器了")
	if 是否可以排序:
		初始化插槽(节点)
	其他区域来的节点=节点
	pass

func 节点退出区域(节点:DragControl):
	#print(name_str,"节点退出容器了")
	if !获取插槽().is_empty():
		清理插槽()
	其他区域来的节点=null
	pass

func 释放的清理操作():
	#print("释放的清理操作")
	拖拽中的节点=null
	进入区域=null
	其他区域来的节点=null
	pass

func 获取所有节点(是否包含拖拽:bool=false)->Array:
	var re=[]
	if 是否包含拖拽 and 拖拽中的节点:
		re.append(拖拽中的节点)
	re.append_array($HBoxContainer.get_children().filter(func(x): return x is DragControl))
	return  re



func 删除(拖拽节点:DragControl):
	#printerr("没有开放")
	pass

func 添加到容器中(拖拽节点:DragControl,index):
	#print(name_str,"添加节点")
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
	#print(name_str,"回归原位置")
	拖拽中的节点.reparent($HBoxContainer)
	$HBoxContainer.move_child(拖拽中的节点, 拖拽时原有索引)

func 开始拖拽(拖拽节点):
	if !是否可以拖拽:
		#print(name_str,"不允许拖拽")
		return
	#print(name_str,"开始拖拽")
	拖拽中的节点=拖拽节点
	拖拽时原有索引=拖拽节点.get_index()
	拖拽节点.reparent(self)
	if 是否可以排序:
		初始化插槽(拖拽节点)
	pass


func 结束拖拽(拖拽节点:DragControl):
	if 是否可以拖拽:
		if 拖拽节点!=拖拽中的节点:
			#print(name_str,"可能出错了")
			拖拽中的节点=拖拽节点
		#print(name_str,"结束拖拽了")
		var 激活的索引=_获取激活的插槽()
		if !获取插槽().is_empty():
			清理插槽()
			await get_tree().process_frame
		if 进入区域:
			#print(name_str,"发送 在其他容器中释放信号")
			在其他容器中释放信号.emit(拖拽节点,进入区域)
		else:
			if 是否可以排序:
				#print(name_str,"排序插槽")
				if 激活的索引==null:
					回到原来位置()
				else:
					添加到容器中(拖拽节点,激活的索引)
			else:
				回到原来位置()
		释放的清理操作()

	

func 新建信号(拖拽节点):
	#print(name_str,"新建信号")
	var temp=拖拽节点.get_signal_connection_list("结束拖拽")
	if !拖拽节点.开始拖拽.is_connected(开始拖拽):
		拖拽节点.开始拖拽.connect(开始拖拽.bind(拖拽节点))
	if !拖拽节点.结束拖拽.is_connected(结束拖拽):
		拖拽节点.结束拖拽.connect(结束拖拽.bind(拖拽节点))

func 断开信号(拖拽节点:DragControl):
	#print(name_str,"断开信号")
	#for i in 拖拽节点.get_signal_connection_list("开始拖拽"):
		#i.signal.disconnect(i.callable)
	#for i in 拖拽节点.get_signal_connection_list("结束拖拽"):
		#i.signal.disconnect(i.callable)
	if 拖拽节点.开始拖拽.is_connected(开始拖拽):
		拖拽节点.开始拖拽.disconnect(开始拖拽)
	if 拖拽节点.结束拖拽.is_connected(结束拖拽):
		拖拽节点.结束拖拽.disconnect(结束拖拽)


#region 排序相关
func 动态更新插槽(节点):
	print(name_str,"动态更新插槽")
	var mp = get_global_mouse_position()
	var height = 节点.size.x*0.5
	## 拖拽时 插槽的动画时间
	var place_holder_duration :float = 0.2
	for holder in 获取插槽():
		var 扩展宽度=节点.size.x/2
		var rect = holder.get_global_rect().grow_individual(扩展宽度,0,扩展宽度,0)
		if rect.has_point(mp):
			if not holder.active:
				holder.active = true
				holder.change_size(节点.size*0.8, place_holder_duration)
		else:
			if holder.active:
				holder.active = false
				holder.change_size(Vector2(4,size.y), place_holder_duration)

func _获取激活的插槽():
	var actives = 获取插槽().filter(func(x): return x.active)
	if actives:
		return actives[0].get_index()/2

func 获取插槽():
	return $HBoxContainer.get_children().filter(func(x): return x is DragSlot)

func 清理插槽():
	#print(name_str,"清理插槽")
	for child in $HBoxContainer.get_children():
		if child is DragSlot:
			child.queue_free()

func 初始化插槽(节点):
	#print(name_str,"初始化插槽")
	var list=$HBoxContainer.get_children()
	for index in list.size()+1:
		var temp插槽=排序的插槽.duplicate()
		temp插槽.size=节点.size
		$HBoxContainer.add_child(temp插槽)
		$HBoxContainer.move_child(temp插槽, index*2)
		if index == 拖拽时原有索引:
			temp插槽.custom_minimum_size = temp插槽.size*0.8
		else:
			temp插槽.custom_minimum_size = Vector2(4,size.y)

#endregion
