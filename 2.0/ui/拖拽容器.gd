extends Control
class_name DragContainer 

@export var 拖入其他的容器:Array[DragContainer]=[]
@export var 是否可以排序:bool=false

var draging_card:DragCard
var _previous_index :int=-1
var 插槽大小:Vector2=Vector2(0,0)

signal 拖拽开始
signal 拖拽结束
signal 拖拽到其他容器

func _process(delta: float) -> void:
	$Panel.size=size
	$"MarginContainer".size=size
	if draging_card:
		自动调整插槽(draging_card.size)
		pass

func 可以拖入边框颜色效果():
	var style = $Panel.get_theme_stylebox("panel") as StyleBoxFlat
	style.border_color=Color(0.753, 0.569, 0.059, 0.6)
	$Panel.add_theme_stylebox_override("panel",style)
	pass

func 恢复边框颜色效果():
	var style = $Panel.get_theme_stylebox("panel") as StyleBoxFlat
	style.border_color=Color(0.8, 0.8, 0.8, 0.6)
	$Panel.add_theme_stylebox_override("panel",style)
	pass

func 获取容器中的卡片()->Array:
	return $MarginContainer/HBoxContainer.get_children()
func 添加卡片(card:DragCard,index):
	if !card.get_parent():
		$MarginContainer/HBoxContainer.add_child(card)
	else:
		card.reparent($MarginContainer/HBoxContainer)
	$MarginContainer/HBoxContainer.move_child(card,index)
	await get_tree().process_frame
	card.拖拽开始.connect(_拖拽开始.bind(card))
	card.拖拽结束.connect(_拖拽结束.bind(card))
	pass

func _拖拽结束(card):
	拖拽结束.emit(card)
	var index=_获取激活的插槽()
	if index==null:
		# 判断有没有移动到其他区域
		if 拖入其他的容器.is_empty():
			_回归原位(card)
			return
		else:
			# 检查是进入其他容器
			var mp = get_global_mouse_position()
			for i in 拖入其他的容器:
				if i.get_global_rect().has_point(mp):
					# 由外部信号决定是否加入
					拖拽到其他容器.emit(card,i)
					_拖拽结束的后续清理()
					return
		# 回归原位
		_回归原位(card)
		return
	else:
		if 是否可以排序:
			_拖拽结束的后续清理()
			# 位置确定
			card.reparent($MarginContainer/HBoxContainer)
			await  get_tree().process_frame
			$MarginContainer/HBoxContainer.move_child(card,index)
			return
		else:
			_回归原位(card)
	pass

func _回归原位(card):
	var index =_previous_index
	_拖拽结束的后续清理()
	card.reparent($MarginContainer/HBoxContainer)
	await  get_tree().process_frame
	$MarginContainer/HBoxContainer.move_child(card,index)
	pass

func _拖拽结束的后续清理(是否处理拖入其他的容器:bool=true):
	# 判断是否离开
	_清理插槽()
	draging_card=null
	_previous_index=-1
	if 是否处理拖入其他的容器:
		for i in 拖入其他的容器:
			i._拖拽结束的后续清理(false)
			i.恢复边框颜色效果()

func _拖拽开始(card):
	拖拽开始.emit(card)
	#print("拖拽。。1")
	draging_card=card
	_previous_index = draging_card.get_index()
	draging_card.reparent(self)
	_添加插槽(draging_card.size)
	pass

func _添加插槽(插槽大小:Vector2,是否处理拖入其他的容器:bool=true):
	if 是否可以排序:
		_清理插槽()
		var list=$MarginContainer/HBoxContainer.get_children()
		for index in list.size()+1:
			var place_holder = preload("uid://cpteykjyr0m8l").instantiate()
			$MarginContainer/HBoxContainer.add_child(place_holder)
			$MarginContainer/HBoxContainer.move_child(place_holder, index*2)
			if index == _previous_index:
				place_holder.custom_minimum_size = 插槽大小*0.8
			else:
				place_holder.custom_minimum_size = Vector2(4,size.y)
	if 是否处理拖入其他的容器:
		for i in 拖入其他的容器:
			i._添加插槽(插槽大小,false)
			i.可以拖入边框颜色效果()


func 获取插槽():
	return $MarginContainer/HBoxContainer.get_children().filter(func(x): return x is Slot)

func 自动调整插槽(插槽大小:Vector2,是否处理拖入其他的容器:bool=true):
	var mp = get_global_mouse_position()
	var height = 插槽大小.x*0.5
	## 拖拽时 插槽的动画时间
	var place_holder_duration :float = 0.2
	for holder:Slot in 获取插槽():
		var 扩展宽度=插槽大小.x/2
		var rect = holder.get_global_rect().grow_individual(扩展宽度,0,扩展宽度,0)
		if rect.has_point(mp):
			if not holder.active:
				holder.active = true
				holder.change_size(插槽大小*0.8, place_holder_duration)
		else:
			if holder.active:
				holder.active = false
				holder.change_size(Vector2(4,size.y), place_holder_duration)
	for i in 拖入其他的容器:
		if i.是否可以排序:
			i.自动调整插槽(插槽大小,false)
		
func _获取激活的插槽():
	var actives = 获取插槽().filter(func(x): return x.active)
	if actives:
		return actives[0].get_index()/2

func _清理插槽(是否处理拖入其他的容器:bool=true):
	var list=$MarginContainer/HBoxContainer.get_children()
	for child in list:
		if child is Slot:
			child.queue_free()
	if 是否处理拖入其他的容器:
		for i in 拖入其他的容器:
			i._清理插槽(false)
