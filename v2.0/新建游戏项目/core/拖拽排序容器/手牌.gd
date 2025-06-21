extends DragContainer

var 箭头初始节点
var 点击时的的位置
var 当前箭头指向区域
var 箭头可以指向的区域:Array=[]
var temp其他容器
var temp拖拽节点


var 当前按下的牌:DragControl=null
var 箭头数据:Dictionary={
	点击时的的位置=Vector2(),
	初始节点=null
}

func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if Global.main_node and Global.main_node.手牌:
			for i in Global.main_node.手牌.获取所有节点(true):
				if i.get_global_rect().has_point(get_global_mouse_position()):
					Logger.debug("找到了当前按下的牌:"+i.card_data.name_str)
					当前按下的牌=i
					# 如果当前按下的牌是法术，则禁止目标排序
					if i.card_data and i.card_data.是否为法术():
						for j in 区域:
							j.是否可以排序=false
	else:
		for j in 区域:
			j.是否可以排序=true
		当前按下的牌=null
	
	if $"箭头".visible:
		#更新箭头位置
		$"箭头".update_curve(箭头数据.点击时的的位置,get_global_mouse_position())
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			# 按下使用
			if 箭头数据.get_or_add("结束节点",null)==null:
				# 取消使用
				拖拽中的节点=箭头数据.初始节点
				回到原来位置()
				pass
			else:
				箭头数据.初始节点.card_data.使用时是否需要选择目标.目标对象=箭头数据.get("结束节点")
				if 箭头数据.初始节点.card_data and 箭头数据.初始节点.card_data.是否为法术():
					箭头数据.初始节点.hide()
					箭头数据.初始节点.queue_free()
				else:
					# 可能是决策 也可能是战吼
					print("抉择 还是 战吼")
					pass
			箭头数据.clear()
			Global.main_node.战场.清理插槽()
			Global.main_node.战场.释放的清理操作()
			释放的清理操作()
			Global.main_node.所有的拖拽禁用或者开启(true)
			$"箭头".hide()
		else:
			# 选择目标中
			箭头数据.结束节点=null
			for i in 箭头数据.箭头可以指向的区域:
				if i.get_global_rect().has_point(get_global_mouse_position()):
					箭头数据.结束节点=i
	else:
		super._process(delta)
	
func _on_在其他容器中释放信号(拖拽: DragControl, 其他容器: DragContainer) -> void:
	if 拖拽.card_data:
		if 拖拽.card_data.使用时是否需要选择目标.是否需要选择目标:
			箭头数据.点击时的的位置=get_global_mouse_position()
			var 所有节点=拖拽.card_data.使用时是否需要选择目标.筛选方法(Global.main_node.获取战场和酒馆中的牌())
			if 所有节点.is_empty():
				# 空置处理
				if 拖拽.card_data and 拖拽.card_data.是否为法术():
					拖拽.hide()
					拖拽.queue_free()
				else:
					其他容器.进入的区域进行释放(拖拽)
					使用触发(拖拽)
				return
			箭头数据.箭头可以指向的区域=所有节点
			箭头数据.初始节点=拖拽
			Global.main_node.所有的拖拽禁用或者开启(false)
			$"箭头".show()
			return
		var 抉择节点=拖拽.card_data.获取抉择节点()
		if 抉择节点!=null:
			print("抉择处理")
			var 抉择ui=抉择节点.duplicate()
			Global.main_node.add_child(抉择ui)
			print(Global.main_node.size)
			#抉择ui.size=Global.main_node.size
			抉择ui.show()
			Global.main_node.所有的拖拽禁用或者开启(false)
			return
	Logger.debug("进入容器了")
	其他容器.进入的区域进行释放(拖拽)
	使用触发(拖拽)

func 添加到容器中(拖拽节点:DragControl,index):
	# todo 判断是否还能继续添加，不能添加就丢弃了
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
