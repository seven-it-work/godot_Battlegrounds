extends SortDragObjContainer


var player:Player

func 只添加到容器中(d:DragObj,index:int=-1):
	if d is CardUI:
		d.cardData.卡片所在位置=Enums.CardPosition.战场
		super.添加到本容器中(d,index)
	else:
		printerr("错误了")
		print_stack()

func 添加到本容器中(d:DragObj,index:int=-1):
	if d is CardUI:
		player.添加卡片(d.cardData,Enums.CardPosition.战场,index,false)
		只添加到容器中(d,index)
	
func 添加到其他容器(拖拽中的对象:DragObj,拖拽的目标容器:DragObjContainer):
	if 拖拽中的对象 is CardUI:
		# 这里可以改为方法了，金币扣除的逻辑由这个方法里面去执行
		player.删除卡牌(拖拽中的对象.cardData,Enums.CardPosition.战场,false)
		super.添加到其他容器(拖拽中的对象,拖拽的目标容器)
	else:
		printerr("错误了")
		print_stack()


func 节点开始拖拽(d:DragObj):
	super.节点开始拖拽(d)
	# 高亮目标
	var p=拖拽的目标容器.get_parent()
	if p is PanelContainer:
		var style=p.get_theme_stylebox("panel") as StyleBoxFlat
		style.border_color=Color(0.975, 0.773, 0.0)
		p.add_theme_stylebox_override("panel",style)
	pass

func 节点结束拖拽(d:DragObj):
	super.节点结束拖拽(d)
	# 高亮目标
	var p=拖拽的目标容器.get_parent()
	if p is PanelContainer:
		var style=p.get_theme_stylebox("panel") as StyleBoxFlat
		style.border_color=Color(0.8, 0.8, 0.8)
		p.add_theme_stylebox_override("panel",style)
	pass
