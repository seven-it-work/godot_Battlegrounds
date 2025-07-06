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
	$"箭头".update_curve(position,get_global_mouse_position())
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		# 如果有目标这设置目标，否则回到原来位置
		var card_data=(当前拖拽中的卡片 as Card).card_data
		var 目标=card_data.使用时是否需要选择目标.筛选方法(palyer.获取战场和酒馆中的牌())
		for i:Card in 目标:
			if i.get_global_rect().has_point(get_global_mouse_position()):
				pass
		pass
	pass


func 获取拖入其他容器的方法操作()->IfElse:
	var ifElse=super.获取拖入其他容器的方法操作()
	ifElse.判断条件方法=func(): return 是否能够使用();
	ifElse.判断失败方法=func(): print("手牌 默认 判断失败方法")
	return ifElse

func 是否能够使用()->bool:
	return true

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
		箭头.visible=true
		card_data.player.遮罩.visible=true
		pass
	pass
