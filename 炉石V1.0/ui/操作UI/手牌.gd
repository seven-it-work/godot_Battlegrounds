extends DragObjContainer

@export var operationUI:OperationUI
var player:Player

func 只添加到容器中(d:DragObj,index:int=-1):
	if d is CardUI:
		d.cardData.卡片所在位置=Enums.CardPosition.手牌
		super.添加到本容器中(d,index)
	else:
		printerr("错误了")
		print_stack()

func 添加到本容器中(d:DragObj,index:int=-1):
	if d is CardUI:
		player.添加卡片(d.cardData,Enums.CardPosition.手牌,index,true)
	else:
		printerr("错误了")
		print_stack()
	
func _process(delta: float) -> void:
	super._process(delta)

func 添加到其他容器(dragObj:DragObj,拖拽的目标容器:DragObjContainer):
	#print("使用手牌")
	if dragObj is CardUI:
		var 拖拽中的对象=dragObj.cardData
		if 拖拽中的对象.卡牌类型==Enums.CardType.随从:
			var 随从取消使用=func(d:DragObj):
				#print("随从取消使用")
				self._回到原来位置()
				pass
			var list=player.获取酒馆And战场的牌()
			if 拖拽中的对象.选择目标对象:
				var 目标list=拖拽中的对象.选择目标对象.获取选择的目标对象(list)
				if 目标list.is_empty():
					#print("直接使用随从")
					_使用成功(dragObj)
				else:
					# 展示选择箭头组件
					operationUI.箭头遮罩.初始化(dragObj,目标list,_使用成功.bind(dragObj),随从取消使用.bind(dragObj))
			elif 拖拽中的对象.抉择:
				#print("抉择随从")
				operationUI.抉择遮罩.初始化(拖拽中的对象,_使用成功.bind(拖拽中的对象),随从取消使用.bind(拖拽中的对象))
				pass
			else:
				#print("随从使用")
				_使用成功(dragObj)
			pass
		elif [Enums.CardType.酒馆法术,Enums.CardType.法术,Enums.CardType.塑造法术].has(拖拽中的对象.卡牌类型):
			var 法术取消使用=func(d:DragObj):
				#print("法术取消使用")
				self.只添加到容器中(d,_拖拽中的对象原有索引)
				pass
			var list=player.获取酒馆And战场的牌()
			if 拖拽中的对象.选择目标对象:
				var 目标list=拖拽中的对象.选择目标对象.获取选择的目标对象(list)
				if 目标list.is_empty():
					#print("法术使用失败，没有目标对象")
					法术取消使用.call(dragObj)
				else:
					# 展示选择箭头组件
					operationUI.箭头遮罩.初始化(dragObj,目标list,_使用成功.bind(dragObj),法术取消使用.bind(dragObj))
			elif 拖拽中的对象.抉择:
				#print("抉择法术")
				operationUI.抉择遮罩.初始化(dragObj,_使用成功.bind(dragObj),法术取消使用.bind(dragObj),player)
				pass
			else:
				#print("法术使用")
				_使用成功(dragObj)
		else:
			printerr("展示不支持这个类型的使用。",拖拽中的对象)
			print_stack()
	else:
		printerr("不支持非炉石卡牌:",dragObj)
		printerr("目标容器：",拖拽的目标容器)

func _使用成功(cardUI:CardUI):
	player.删除卡牌(cardUI.cardData,Enums.CardPosition.手牌,false)
	var cardData=cardUI.cardData
	if cardData is BaseMinion:
		for i:Roar in cardData.战吼:
			i.战吼执行()
		if cardData.是否为磁力:
			if 拖拽的目标容器 is SortDragObjContainer:
				var 右边的随从UI=拖拽的目标容器.获取插槽右边的卡片() as CardUI
				if 右边的随从UI:
					var 右边的随从=右边的随从UI.cardData
					if 右边的随从 is BaseMinion and 右边的随从.race.has(Enums.CardRace.机械):
						右边的随从.添加磁力(cardUI.cardData)
						player.使用卡牌信号.emit(cardUI.cardData)
						cardUI.queue_free()
						return
		super.添加到其他容器(cardUI,拖拽的目标容器)
		player.使用卡牌信号.emit(cardUI.cardData)
	elif cardData is BaseSpell:
		player.使用卡牌信号.emit(cardUI.cardData)
		cardData.法术使用处理()
		cardUI.queue_free()
	else:
		printerr("卡片类型无法使用",cardData)

func _回到原来位置():
	self.只添加到容器中(_拖拽中的对象,_拖拽中的对象原有索引)

func 节点拖拽中(d:DragObj):
	super.节点拖拽中(d)
	if 拖拽的目标容器:
		if 拖拽的目标容器 is SortDragObjContainer:
			if 拖拽的目标容器.get_global_rect().has_point(get_global_mouse_position()):
				拖拽的目标容器._添加插槽(d)
			else:
				拖拽的目标容器._清理插槽()
	pass

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
