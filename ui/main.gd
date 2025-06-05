extends Control
# 实时选中的卡
var select_card:CardUi=null
var player:Player
# 需要额外选中目标的卡
var 选择的cardUi:CardUi
var 选择的继续运行方法

func _ready() -> void:
	Globals.main_node=self
	for i in $PanelContainer/HBoxContainer/core/酒馆.get_children():
		i.queue_free()
	for i in $PanelContainer/HBoxContainer/core/战场.get_children():
		i.queue_free()
	for i in $PanelContainer/HBoxContainer/core/手牌.get_children():
		i.queue_free()
	# 玩家初始化
	var player=preload("uid://duyyralberadj").instantiate()
	self.player=player
	# test
	player.buy_card(preload("uid://c84v1i3ulob37").instantiate())
	player.手牌的牌变化=true
	# endtest
	$"PanelContainer/HBoxContainer/操作/PanelContainer/VBoxContainer/提示信息/酒馆提示信息".player=player
	$"PanelContainer/HBoxContainer/操作/PanelContainer/VBoxContainer/提示信息/战场提示信息".player=player
	$"PanelContainer/HBoxContainer/操作/PanelContainer/VBoxContainer/提示信息/手牌提示信息".player=player
	# 酒馆信息加载
	player.tavern.新的开始()
	#for i in 7:
		#var temp=preload("uid://q15lwiw1ep3v").instantiate()
		#player.tavern.current_card.append(temp)
	#player.酒馆的牌变化=true
	pass

func _process(delta: float) -> void:
	if player:
		if player.战场的牌变化:
			战场的牌变化()
		if player.手牌的牌变化:
			手牌的牌变化()
		if player.酒馆的牌变化:
			酒馆的牌变化()
	pass

#region 与player的交互方法
func 战场的牌变化():
	for i in $PanelContainer/HBoxContainer/core/战场.get_children():
		i.queue_free()
	for i in player.战场中的牌:
		var node=preload("uid://dl0ad8ft57aqx").instantiate()
		node.initData(i)
		node.位置=CardUi.PositionEnum.战场
		node.select.connect(select_card_func.bind(node))
		$PanelContainer/HBoxContainer/core/战场.add_child(node)
	player.战场的牌变化=false
func 手牌的牌变化():
	for i in $PanelContainer/HBoxContainer/core/手牌.get_children():
		i.queue_free()
	for i in player.手牌:
		var node=preload("uid://dl0ad8ft57aqx").instantiate()
		node.initData(i)
		node.位置=CardUi.PositionEnum.手牌
		node.select.connect(select_card_func.bind(node))
		$PanelContainer/HBoxContainer/core/手牌.add_child(node)
	player.手牌的牌变化=false
func 酒馆的牌变化():
	for i in $PanelContainer/HBoxContainer/core/酒馆.get_children():
		i.queue_free()
	for i in player.tavern.current_card:
		var node=preload("uid://dl0ad8ft57aqx").instantiate()
		node.initData(i)
		node.位置=CardUi.PositionEnum.酒馆
		node.select.connect(select_card_func.bind(node))
		$PanelContainer/HBoxContainer/core/酒馆.add_child(node)
	player.酒馆的牌变化=false
#endregion


func 提示信息修改(cardUi:CardUi):
	for i in $"PanelContainer/HBoxContainer/操作/PanelContainer/VBoxContainer/提示信息".get_children():
		i.hide()
	if cardUi==null:
		return
	if cardUi.位置==CardUi.PositionEnum.酒馆:
		$"PanelContainer/HBoxContainer/操作/PanelContainer/VBoxContainer/提示信息/酒馆提示信息".initData(cardUi)
		$"PanelContainer/HBoxContainer/操作/PanelContainer/VBoxContainer/提示信息/酒馆提示信息".show()
		return
	if cardUi.位置==CardUi.PositionEnum.战场:
		$"PanelContainer/HBoxContainer/操作/PanelContainer/VBoxContainer/提示信息/战场提示信息".initData(cardUi)
		$"PanelContainer/HBoxContainer/操作/PanelContainer/VBoxContainer/提示信息/战场提示信息".show()
		return
	if cardUi.位置==CardUi.PositionEnum.手牌:
		$"PanelContainer/HBoxContainer/操作/PanelContainer/VBoxContainer/提示信息/手牌提示信息".initData(cardUi)
		$"PanelContainer/HBoxContainer/操作/PanelContainer/VBoxContainer/提示信息/手牌提示信息".show()
		return

func select_card_func(card:CardUi):
	if select_card:
		select_card.select_theme_change(false)
	select_card=card
	select_card.select_theme_change(true)
	# 添加提示信息
	提示信息修改(card)
	pass
