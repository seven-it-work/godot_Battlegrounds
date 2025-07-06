extends Control

class_name CardContainer

@export var 可以拖入的容器:Array[CardContainer] = [] 
@export var name_str:String
@onready var container:=$HBoxContainer
@export var palyer:Player

# 未拖拽 在本容器中 在其他容器中 没在容器中
var 拖拽卡片的状态:String="未拖拽"
# 从开始拖拽 到结束拖拽 这个都会存在才对
var 当前拖拽中的卡片:CardUI
var 是否拖拽中:bool=false
var 当前拖拽中的卡片的原有索引:int=-1
var 当前拖入的容器:CardContainer
var 是否能拖拽标识:bool=true

func 获取所有节点()->Array[CardUI]:
	var list := [] as Array[CardUI]
	for child in container.get_children():
		if child is CardUI:
			list.append(child)
	return list

func 是否能拖拽(是否能:bool):
	是否能拖拽标识=是否能
	for i in container.get_children():
		if i is CardUI:
			i.是否能拖拽=是否能

func _绑定信号(cardUi:CardUI):
	cardUi.开始拖拽.connect(监听开始拖拽.bind(cardUi))
	cardUi.结束拖拽.connect(监听结束拖拽.bind())
	pass

func _解除信号(cardUi:CardUI):
	cardUi.开始拖拽.disconnect(监听开始拖拽.bind(cardUi))
	cardUi.结束拖拽.disconnect(监听结束拖拽.bind())
	pass

func 添加到容器(cardUi:CardUI,index:int):
	_绑定信号(cardUi)
	# 添加到容器中
	_add(cardUi,index)
	pass

func 监听开始拖拽(cardUi:CardUI):
	拖拽卡片的状态="在本容器中"
	当前拖拽中的卡片的原有索引=cardUi.get_index()
	# 改变cardUi的父节点
	当前拖拽中的卡片=cardUi
	是否拖拽中=true
	当前拖拽中的卡片.reparent(self)
	pass

func 获取拖入其他容器的方法操作()->IfElse:
	var ifElse=IfElse.new()
	ifElse.判断条件方法=func(): return true;
	ifElse.判断成功方法=func():
		_解除信号(当前拖拽中的卡片)
		当前拖入的容器.添加到容器(当前拖拽中的卡片,-1)
		拖离其他容器()
		_拖拽结束时的清理动作()
	ifElse.判断失败方法=func(): _拖拽结束时的清理动作()
	return ifElse

func _在其他容器中释放前的操作(ifEsle:IfElse):
	pass

func 监听结束拖拽():
	if 当前拖入的容器:
		var ifElse=获取拖入其他容器的方法操作()
		_在其他容器中释放前的操作(ifElse)
		if ifElse.判断条件方法.call():
			ifElse.判断成功方法.call()
		else:
			ifElse.判断失败方法.call()
	else:
		回归原位()
		_拖拽结束时的清理动作()
	pass

func _拖拽结束时的清理动作():
	当前拖拽中的卡片=null
	是否拖拽中=false
	当前拖拽中的卡片的原有索引=-1

func 回归原位():
	_add(当前拖拽中的卡片,当前拖拽中的卡片的原有索引)

func _add(cardUi:CardUI,index:int):
	if cardUi.get_parent():
		cardUi.reparent(container)
	else:
		container.add_child(cardUi)
	container.move_child(cardUi,index)
	pass

func 拖进其他容器(容器:CardContainer):
	assert(当前拖入的容器==null, "错误了！已经存在了拖入的容器，请先清理")
	当前拖入的容器=容器
	拖拽卡片的状态="在其他容器中"
	容器.拖入本容器(当前拖拽中的卡片)
	pass

func 拖离其他容器():
	当前拖入的容器.拖离本容器()
	当前拖入的容器.当前拖拽中的卡片=null
	当前拖入的容器=null
	pass

func 拖入本容器(cardUi:CardUI):
	拖拽卡片的状态="在本容器中"
	当前拖拽中的卡片=cardUi
	pass

func 拖离本容器():
	pass

func _当前鼠标是否在容器中(cardContainer:CardContainer)->bool:
	return cardContainer.get_global_rect().has_point(get_global_mouse_position())

func _process(delta: float) -> void:
	$Panel.size=size
	$HBoxContainer.size=size
	if !是否能拖拽标识:
		return
	if 当前拖拽中的卡片 and 是否拖拽中:
		print(name_str,拖拽卡片的状态)
		if 拖拽卡片的状态=="未拖拽":
			当前拖拽中的卡片=null
			pass
		elif 拖拽卡片的状态=="在本容器中":
			if _当前鼠标是否在容器中(self):
				pass
			else:
				拖离本容器()
				var 其他容器= _检测是否拖入了其他容器()
				if 其他容器:
					拖进其他容器(其他容器)
				else:
					拖拽卡片的状态="没在容器中"
		elif 拖拽卡片的状态=="在其他容器中":
			if _当前鼠标是否在容器中(self):
				拖离其他容器()
				拖入本容器(当前拖拽中的卡片)
			else:
				var 其他容器= _检测是否拖入了其他容器()
				if 其他容器:
					if 当前拖入的容器==其他容器:
						pass
					else:
						if 当前拖入的容器:
							拖离其他容器()
						拖进其他容器(其他容器)
				else:
					拖离其他容器()
					拖拽卡片的状态="没在容器中"
		elif 拖拽卡片的状态=="没在容器中":
			if _当前鼠标是否在容器中(self):
				拖入本容器(当前拖拽中的卡片)
			else:
				var 其他容器= _检测是否拖入了其他容器()
				if 其他容器:
					拖进其他容器(其他容器)
				else:
					pass
		else:
			printerr("不存在状态")

	
func _检测是否拖入了其他容器()->CardContainer:
	# 遍历 可以拖入的容器
	for i in 可以拖入的容器:
		if _当前鼠标是否在容器中(i):
				return i
	return null
	
