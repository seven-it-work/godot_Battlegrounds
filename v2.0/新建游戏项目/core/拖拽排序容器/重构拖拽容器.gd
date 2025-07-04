class_name CardUi
signal 开始拖拽()
signal 结束拖拽()

class_name CardContainer

@@export var 可以拖入的容器 = [] 
var 当前拖拽中的卡片
var 当前拖入的容器


func 添加到容器(cardUi,index):
	绑定信号(cardUi)
	# 添加到容器中
	_add(cardUi,index)
	pass

func 监听开始拖拽(cardUi):
	# 改变cardUi的父节点
	当前拖拽中的卡片=cardUi
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

func 回归原位():
	_add(当前拖拽中的卡片,当前拖拽中的卡片.get_index())
	pass

func _add(cardUi,index):
	pass

func 拖进了容器(容器):
	if 当前拖入的容器:
		print("错误了！已经存在了拖入的容器，请先清理")
		# todo 这里改为抛异常
		return
	当前拖入的容器=容器
	pass

func 拖离了容器():
	当前拖入的容器=null
	pass

func _process():
	if 当前拖拽中的卡片:
		# 遍历 可以拖入的容器
		for i in 可以拖入的容器:
			if 当前鼠标是否在容器中(i):
				if i==当前拖入的容器:
					# 没有改变
					break
				else:
					if 当前拖入的容器:
						拖离了容器()
					拖进了容器(i)
					break
			else:
				if i==当前拖入的容器:
					拖离了容器()
					break
	pass