extends PanelContainer

@onready var 物品集合:=$"HSplitContainer/ItemUI/ScrollContainer/物品集合"
@onready var 信息:=$"HSplitContainer/信息"

@export var 横向背包个数:int=10
@export var 背包容量:int=100

var _当前点击的物品:ItemUI

func _ready() -> void:
	物品集合.columns=横向背包个数
	for i in 背包容量:
		物品集合.add_child(_获取空格())
	

func _获取空格():
	var 空格=preload("uid://cj2r04ptpglgd").instantiate()
	空格._是否为空格=true
	return 空格

func 添加物品(itemUI:ItemUI):
	var 非空格集合=物品集合.get_children().filter(func(temp): return !temp._是否为空格)
	if 非空格集合.size()>=背包容量:
		print("无法添加了，背包到达上限")
		return
	if itemUI.是否可以叠加:
		for i:ItemUI in 非空格集合:
			if itemUI.判断是否为同一物品(i):
				i.叠加数量+=1
				return
	物品集合.get_children().get(背包容量-1).free()
	if itemUI.get_parent():
		itemUI.reparent(物品集合)
	else:
		物品集合.add_child(itemUI)
	物品集合.move_child(itemUI,非空格集合.size())
	itemUI.鼠标悬浮在当前物品.connect(_鼠标悬浮在当前物品.bind(itemUI))
	itemUI.鼠标离开在当前物品.connect(_鼠标离开在当前物品.bind(itemUI))
	itemUI.点击物品信号.connect(_点击物品信号.bind(itemUI))
	await get_tree().process_frame
	pass

func _点击物品信号(itemUI:ItemUI):
	if _当前点击的物品:
		_当前点击的物品.选中样式更改("取消选中")
	_当前点击的物品=itemUI
	_当前点击的物品.选中样式更改("选中")
	pass

func _鼠标悬浮在当前物品(itemUI:ItemUI):
	信息.更新信息(itemUI)
	pass

func _鼠标离开在当前物品(itemUI:ItemUI):
	信息.清空信息()
	pass
