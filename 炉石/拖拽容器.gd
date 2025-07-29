extends Control
class_name DragObjContainer

@onready var 容器:=$HBoxContainer
@export var 拖拽的目标容器:DragObjContainer
var _拖拽中的对象:DragObj
var _拖拽中的对象原有索引:int

func 添加到本容器中(d:DragObj,index:int=-1):
	if d.get_parent():
		d.reparent(容器)
	else:
		容器.add_child(d)
	容器.move_child(d,index)
	_解除信号(d)
	_添加信号(d)
	pass

func 节点开始拖拽(d:DragObj):
	d.reparent(self)
	_拖拽中的对象原有索引=get_index()
	_拖拽中的对象=d
	pass
	
func 节点拖拽中(d:DragObj):
	pass

func 添加到其他容器(拖拽中的对象:DragObj,拖拽的目标容器:DragObjContainer):
	拖拽的目标容器.添加到本容器中(拖拽中的对象)
	pass

func 节点结束拖拽(d:DragObj):
	print("节点结束拖拽")
	if _拖拽中的对象!=d:
		printerr("错误了")
	if 拖拽的目标容器:
		if 拖拽的目标容器.get_rect().has_point(get_global_mouse_position()):
			添加到其他容器(d,拖拽的目标容器)
			拖拽的目标容器._结束清理操作()
			_结束清理操作()
			return
	添加到本容器中(d,_拖拽中的对象原有索引)
	_结束清理操作()

func _结束清理操作():
	_拖拽中的对象原有索引=-1
	_拖拽中的对象=null

func _添加信号(d:DragObj):
	if !d.开始拖拽.is_connected(节点开始拖拽.bind(d)):
		d.开始拖拽.connect(节点开始拖拽.bind(d))
	if !d.拖拽中.is_connected(节点拖拽中.bind(d)):
		d.拖拽中.connect(节点拖拽中.bind(d))
	if !d.结束拖拽.is_connected(节点结束拖拽.bind(d)):
		d.结束拖拽.connect(节点结束拖拽.bind(d))
	pass

func _解除信号(d:DragObj):
	var 信号=d.开始拖拽.get_connections()
	for i in 信号:
		var s=i.signal as Signal
		s.disconnect(i.callable)
