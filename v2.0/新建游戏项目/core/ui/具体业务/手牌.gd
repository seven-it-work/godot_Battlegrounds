extends CardContainer

@onready var 箭头:=$"箭头"

func _process(delta: float) -> void:
	super._process(delta)
	_检测箭头是否选中对象()
	pass


func _检测箭头是否选中对象():
	if !箭头.visible:
		return
	# 绘制箭头
	$"箭头".update_curve(当前拖拽中的卡片.global_position+当前拖拽中的卡片.size/2,get_global_mouse_position())
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		# 如果有目标这设置目标，否则回到原来位置
		var card_data=(当前拖拽中的卡片 as Card).card_data
		var list=palyer.获取战场和酒馆中的牌()
		var 目标=card_data.使用时是否需要选择目标.筛选方法(list)
		var 选中的目标=null
		for i:Card in 目标:
			if i.get_global_rect().has_point(get_global_mouse_position()):
				选中的目标=i
		if 选中的目标:
			var temp=当前拖拽中的卡片
			card_data.使用时是否需要选择目标.目标对象=选中的目标
			card_data.使用触发()
			# 回归原来位置
			箭头.visible=false
			card_data.player.遮罩.visible=false
			palyer.所有的拖拽禁用或者开启(true)
			拖离其他容器()
			回归原位()
			_拖拽结束时的清理动作()
			# 移除卡牌
			temp.hide()
			temp.queue_free()
		else:
			# 回归原来位置
			箭头.visible=false
			card_data.player.遮罩.visible=false
			palyer.所有的拖拽禁用或者开启(true)
			拖离其他容器()
			回归原位()
			_拖拽结束时的清理动作()
		pass
	pass


func 获取拖入其他容器的方法操作()->IfElse:
	var ifElse=super.获取拖入其他容器的方法操作()
	ifElse.判断条件方法=func(): return 是否能够使用();
	ifElse.判断失败方法=func(): 
		拖离其他容器()
		回归原位()
		_拖拽结束时的清理动作()
	return ifElse

func 是否能够使用()->bool:
	var card_data=(当前拖拽中的卡片 as Card).card_data
	return card_data.是否能够使用()

func _在其他容器中释放前的操作(ifEsle:IfElse):
	使用卡牌(ifEsle)
	pass

func 使用卡牌(ifElse:IfElse):
	var card_data=(当前拖拽中的卡片 as Card).card_data
	if !card_data.是否能够使用():
		Logger.error("不能使用卡牌")
		return
	if card_data.使用时是否需要选择目标 and card_data.使用时是否需要选择目标.是否需要选择目标:
		Logger.debug("用户选中目标")
		ifElse.判断条件方法=func(): return false;
		ifElse.判断失败方法=func(): print("手牌 默认 判断失败方法")
		箭头.visible=true
		card_data.player.遮罩.visible=true
		palyer.所有的拖拽禁用或者开启(false)
		return
	card_data.使用触发()
	pass
