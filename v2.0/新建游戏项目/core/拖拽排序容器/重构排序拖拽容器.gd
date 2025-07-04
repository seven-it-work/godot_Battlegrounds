class_name CardSortContainer extends CardContainer

func 拖进了容器(容器):
	super.拖进了容器(容器)
	_初始化卡槽()

func _初始化卡槽():
	pass

func 拖离了容器():
	super.拖离了容器()
	_清理卡槽()
	pass

func _清理卡槽():
	pass

func 监听结束拖拽():
	if 当前拖入的容器:
		解除信号(当前拖拽中的卡片)
		当前拖入的容器.添加到容器(当前拖拽中的卡片,-1)
		拖离了容器()
	else:
		回归原位()
	当前拖拽中的卡片=null
	pass

func _动态更新插槽():
	pass

func _process():
	super._process()
	if 当前拖拽中的卡片:
		_动态更新插槽()
		pass