extends DragObjContainer
class_name SortDragObjContainer
@export var 插槽:SortSlot=preload("uid://l7pqd1a0ewu").instantiate()

var _插槽是否初始化:bool=false

func _ready() -> void:
	pass

func 节点拖拽中(d:DragObj):
	if 拖拽的目标容器:
		if 拖拽的目标容器 is SortDragObjContainer:
			if 拖拽的目标容器.get_rect().has_point(get_global_mouse_position()):
				拖拽的目标容器._添加插槽(d)
			else:
				拖拽的目标容器._清理插槽()

func 节点结束拖拽(d:DragObj):
	print("排序节点结束拖拽")
	_清理插槽()
	super.节点结束拖拽(d)
	print(容器.get_children())

func _清理插槽():
	_插槽是否初始化=false
	var list=容器.get_children()
	for child in list:
		print(child)
		if child is SortSlot:
			print("释放插槽")
			child.queue_free()

func _添加插槽(d:DragObj):
	if _插槽是否初始化:
		_自动调整插槽(d)
		return
	_插槽是否初始化=true
	var 数量=容器.get_children().size()
	for index in 数量+1:
		var place_holder=插槽.duplicate() as SortSlot
		容器.add_child(place_holder)
		容器.move_child(place_holder, index*2)
		if index == _拖拽中的对象原有索引:
			print(_拖拽中的对象原有索引,"true")
			place_holder.custom_minimum_size = d.size*0.8
		else:
			print(_拖拽中的对象原有索引,"false")
			place_holder.custom_minimum_size = Vector2(4,size.y)


func 获取插槽():
	return 容器.get_children().filter(func(x): return x is SortSlot)

func _自动调整插槽(d:DragObj):
	var mp = get_global_mouse_position()
	var height = d.size.x*0.5
	## 拖拽时 插槽的动画时间
	var place_holder_duration :float = 0.2
	for holder:SortSlot in 获取插槽():
		var 扩展宽度=d.size.x/2
		var rect = holder.get_global_rect().grow_individual(扩展宽度,0,扩展宽度,0)
		if rect.has_point(mp):
			if not holder.active:
				holder.active = true
				holder.change_size(d.size*0.8, place_holder_duration)
		else:
			if holder.active:
				holder.active = false
				holder.change_size(Vector2(4,size.y), place_holder_duration)
		
