extends Control

var select_card=null

func _ready() -> void:
	for i in $PanelContainer/HBoxContainer/core/酒馆.get_children():
		i.queue_free()
	for i in $PanelContainer/HBoxContainer/core/随从.get_children():
		i.queue_free()
	for i in $PanelContainer/HBoxContainer/core/手牌.get_children():
		i.queue_free()
		
	test()
	pass

func test():
	for i in 7:
		添加卡牌到酒馆(preload("uid://q15lwiw1ep3v").instantiate())

func 添加卡牌到酒馆(card:BaseCard):
	var node=preload("uid://dl0ad8ft57aqx").instantiate()
	node.initData(card)
	node.位置=CardUi.PositionEnum.酒馆
	node.select.connect(select_card_func.bind(node))
	$PanelContainer/HBoxContainer/core/酒馆.add_child(node)
	

func select_card_func(card):
	if select_card:
		select_card.select_theme_change(false)
		# 清理提示信息
	select_card=card
	select_card.select_theme_change(true)
	# 添加提示信息
	pass
