extends CardContainer

@export var 排序的插槽:DragSlot=preload("uid://uo2gx7wimlt8").instantiate()
var 是否初始卡槽:bool=false

func 拖入本容器(cardUi:CardUI):
	super.拖入本容器(cardUi)
	_初始化卡槽()
	pass
	
func 拖离本容器():
	super.拖离本容器()
	_清理卡槽()
	pass

func 监听开始拖拽(cardUi:CardUI):
	super.监听开始拖拽(cardUi)
	_初始化卡槽()

func 监听结束拖拽():
	var 激活的索引=_获取激活的插槽()
	if 激活的索引==null:
		super.监听结束拖拽()
	else:
		_add(当前拖拽中的卡片,激活的索引)
	_清理卡槽()

func _初始化卡槽():
	if 是否初始卡槽:
		return
	是否初始卡槽=true
	var list=$HBoxContainer.get_children()
	for index in list.size()+1:
		var temp插槽=排序的插槽.duplicate()
		temp插槽.size=当前拖拽中的卡片.size
		$HBoxContainer.add_child(temp插槽)
		$HBoxContainer.move_child(temp插槽, index*2)
		if index == 当前拖拽中的卡片的原有索引:
			temp插槽.custom_minimum_size = temp插槽.size*0.8
		else:
			temp插槽.custom_minimum_size = Vector2(4,size.y)


func _清理卡槽():
	是否初始卡槽=false
	for child in $HBoxContainer.get_children():
		if child is DragSlot:
			child.queue_free()


func _动态更新插槽():
	var mp = get_global_mouse_position()
	var height = 当前拖拽中的卡片.size.x*0.5
	## 拖拽时 插槽的动画时间
	var place_holder_duration :float = 0.2
	for holder in _获取插槽():
		var 扩展宽度=当前拖拽中的卡片.size.x/2
		var rect = holder.get_global_rect().grow_individual(扩展宽度,0,扩展宽度,0)
		if rect.has_point(mp):
			if not holder.active:
				holder.active = true
				holder.change_size(当前拖拽中的卡片.size*0.8, place_holder_duration)
		else:
			if holder.active:
				holder.active = false
				holder.change_size(Vector2(4,size.y), place_holder_duration)

func _获取插槽():
	return $HBoxContainer.get_children().filter(func(x): return x is DragSlot)

func _获取激活的插槽():
	var actives = _获取插槽().filter(func(x): return x.active)
	if actives:
		return actives[0].get_index()/2

func _process(delta: float) -> void:
	super._process(delta)
	if !是否能拖拽标识:
		return
	if 当前拖拽中的卡片:
		_动态更新插槽()
		pass
