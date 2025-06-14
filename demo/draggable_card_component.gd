## 卡牌拖拽list组件
class_name DraggableCardComponent extends HBoxContainer

## 卡牌节点
@export var PLACE_HOLDER_PACKED_SCENE:PackedScene=preload("uid://dv8cuue624nja")
## 拖拽时的大小
@export var place_holder_min_size:=Vector2(4,200)
## 拖拽时 插槽的动画时间
@export var place_holder_duration :float = 0.2
## 拖拽时的阴影
@export var _shadow_panel_packed_scene:PackedScene =preload("uid://kk3f145b1ybm")

@export var 脱离区域禁止排序:bool=true

var 检测区域:Rect2


var _draged_card:BaseDragableCard
var _drag_offset := Vector2.ZERO
var _previous_index :int
var _shadow_panel:Panel

signal 开始拖拽
signal 停止拖拽

func 获取拖拽区域()->Rect2:
	if 检测区域:
		return 检测区域
	return get_global_rect()

func _ready():
	clear_cards()
		
func _process(delta):
	_draging()
	
func _input(event):
	if event is InputEventMouseButton:
		if not event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			_stop_drag()

## Interface
func clear_cards():
	for child in get_children():
		remove_card(child)

func add_card(value:BaseDragableCard):
	if value not in get_children():
		add_child(value)
		var call_start = _start_drag.bind(value)
		if not value.drag_started.is_connected(call_start):
			value.drag_started.connect(call_start)
		if not value.drag_stoped.is_connected(_stop_drag):
			value.drag_stoped.connect(_stop_drag)

func remove_card(value:BaseDragableCard):
	if value in get_children():
		remove_child(value)

func get_cards():
	return get_children().filter(func(x): return x is BaseDragableCard)

func _remove_all_place_holder():
	for child in get_children():
		if child is PlaceHolderPanel:
			remove_child(child)
			child.queue_free()

func _add_place_holder():
	_remove_all_place_holder()
	for index in get_child_count()+1:
		var place_holder = PLACE_HOLDER_PACKED_SCENE.instantiate()
		add_child(place_holder)
		move_child(place_holder, index*2)
		if index == _previous_index:
			place_holder.custom_minimum_size = _draged_card.size*0.8
		else:
			place_holder.custom_minimum_size = place_holder_min_size

func _get_place_holders():
	return get_children().filter(func(x): return x is PlaceHolderPanel)

func _get_active_holder_index():
	var actives = _get_place_holders().filter(func(x): return x.active)
	if actives:
		return actives[0].get_index()/2


func _auto_change_place_holder_size():
	if not _draged_card:
		return 
	var mp = get_global_mouse_position()
	var height = _draged_card.size.x*0.5
	if 获取拖拽区域().has_point(mp):
		#print("鼠标在区域内")
		pass
	else:
		#print("鼠标不在了")
		if 脱离区域禁止排序:
			return
	for holder:PlaceHolderPanel in _get_place_holders():
		var rect = holder.get_global_rect()
		if abs(mp.x - rect.position.x) <= height or abs(mp.x - rect.end.x) <= height:
			if not holder.active:
				holder.active = true
				holder.change_size(_draged_card.size*0.8, place_holder_duration)
		else:
			if holder.active:
				holder.active = false
				holder.change_size(place_holder_min_size, place_holder_duration)

func _start_drag(value:BaseDragableCard):
	#print("开始排序")
	_draged_card = value
	if not _draged_card:
		return 
	
	开始拖拽.emit()
	_drag_offset = _draged_card.global_position-get_global_mouse_position()
	
	_previous_index = _draged_card.get_index()
	remove_card(_draged_card)
	_add_place_holder()
	get_tree().root.add_child(_draged_card)
	
	_shadow_panel = _shadow_panel_packed_scene.instantiate()
	_draged_card.add_child(_shadow_panel)
	_shadow_panel.show_behind_parent = true

func _draging():
	if not _draged_card:
		return 
	_draged_card.global_position = get_global_mouse_position()+_drag_offset
	_auto_change_place_holder_size()

func _stop_drag():
	#print("停止排序")
	if not _draged_card:
		return 
	停止拖拽.emit(_draged_card)
	
	var index = _get_active_holder_index()
	if index == null:
		index = _previous_index
	get_tree().root.remove_child(_draged_card)
	_remove_all_place_holder()
	add_card(_draged_card)
	move_child(_draged_card, index)
	_draged_card = null
	_shadow_panel.queue_free()
	
