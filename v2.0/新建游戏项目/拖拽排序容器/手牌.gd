extends DragContainer

var 箭头初始节点
var 点击时的的位置
var 当前箭头指向区域
var 箭头可以指向的区域:Array=[]
var temp其他容器
var temp拖拽节点

func _process(delta: float) -> void:
	if $"箭头".visible:
		$"箭头".update_curve(点击时的的位置,get_global_mouse_position())
		当前箭头指向区域=null
		for i in 箭头可以指向的区域:
			if i.get_global_rect().has_point(get_global_mouse_position()):
				当前箭头指向区域=i
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			if 当前箭头指向区域:
				#print("箭头使用")
				temp其他容器.进入的区域进行释放(temp拖拽节点)
				var card=temp拖拽节点.card_data as CardData
				card.获取战吼节点().战吼目标=当前箭头指向区域
				使用触发(temp拖拽节点)
			else:
				#print("没有指向，回退")
				拖拽中的节点=temp拖拽节点
				回到原来位置()
				释放的清理操作()
				temp其他容器.清理插槽()
			当前箭头指向区域=null
			$"箭头".hide()
			Global.main_node.所有的拖拽禁用或者开启(true)
	else:
		super._process(delta)
		手牌使用检查()

func 手牌使用检查():
	if 拖拽中的节点:
		return
	# 手牌箭头检测
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if $"使用箭头".visible:
			$"使用箭头".update_curve(点击时的的位置,get_global_mouse_position())
		else:
			for i in 获取所有节点():
				if i.get_global_rect().has_point(get_global_mouse_position()):
					if !i.是否可以拖拽判断():
						#print("判断区域",i.label.text)
						var card_data=i.card_data as CardData
						if card_data.使用时是否需要选择目标.是否需要选择目标:
							var 所有节点=card_data.使用时是否需要选择目标.筛选方法(Global.main_node.获取所有的牌())
							箭头可以指向的区域=所有节点
							if !箭头可以指向的区域.is_empty():
								Global.main_node.所有的拖拽禁用或者开启(false)
								#print("使用的箭头")
								箭头初始节点=i
								点击时的的位置 = get_global_mouse_position()
								$"使用箭头".show()
	else:
		if $"使用箭头".visible:
			for i in 箭头可以指向的区域:
				if i.get_global_rect().has_point(get_global_mouse_position()):
					当前箭头指向区域=i
			if 当前箭头指向区域:
				箭头初始节点.hide()
				使用触发(箭头初始节点)
				箭头初始节点.queue_free()
			else:
				#print("取消使用")
				pass
			当前箭头指向区域=null
			Global.main_node.所有的拖拽禁用或者开启(true)
			$"使用箭头".hide()

func _on_在其他容器中释放信号(拖拽: DragControl, 其他容器: DragContainer) -> void:
	temp其他容器=其他容器
	temp拖拽节点=拖拽
	if 拖拽.card_data.战吼时是否需要选择目标():
		var roar=拖拽.card_data.获取战吼节点()
		箭头初始节点=拖拽
		点击时的的位置 =get_global_mouse_position()
		Global.main_node.所有的拖拽禁用或者开启(false)
		var 所有节点=roar.targetSelector.筛选方法(Global.main_node.获取所有的牌())
		箭头可以指向的区域=所有节点
		if !箭头可以指向的区域.is_empty():
			$"箭头".show()
		else:
			Global.main_node.所有的拖拽禁用或者开启(true)
			其他容器.进入的区域进行释放(拖拽)
			使用触发(拖拽)
	else:
		其他容器.进入的区域进行释放(拖拽)
		使用触发(拖拽)

func 添加到容器中(拖拽节点:DragControl,index):
	# todo 判断是否还能继续添加，不能添加就丢弃了
	
	if 拖拽节点.card_data:
		if 拖拽节点.card_data.使用时是否需要选择目标.是否需要选择目标:
			拖拽节点.是否可以拖拽=false
	拖拽节点.card_data.所在位置=Enums.CardPosition.手牌
	添加到手牌触发()
	super.添加到容器中(拖拽节点,index)
	pass

func 添加到手牌触发():
	print("添加到手牌")
	pass

func 使用触发(使用卡片:DragControl):
	print("使用触发")
	使用卡片.card_data.使用触发(Global.main_node)
	for i:DragControl in Global.main_node.获取所有的牌():
		if i!=使用卡片:
			i.card_data.使用触发监听(Global.main_node,使用卡片)
	pass
