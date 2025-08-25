extends Control
class_name OperationUI

@export var player:Player
@onready var 酒馆:=%"酒馆"
@onready var 战场:=%"战场"
@onready var 手牌:=%"手牌"
@onready var tips:=%"Tips"
@onready var 箭头遮罩:=$"PanelContainer/箭头遮罩"
@onready var 抉择遮罩:=$"PanelContainer/抉择遮罩"
signal 结束回合信号

func _process(delta: float) -> void:
	var list=[]
	list.append_array(酒馆.获取所有的拖拽象())
	list.append_array(战场.获取所有的拖拽象())
	list.append_array(手牌.获取所有的拖拽象())
	for i in list:
		if i.get_global_rect().has_point(get_global_mouse_position()):
			if tips.当前Tips==null:
				tips.更新当前Tps(i.cardData)
				pass
			elif tips.当前Tips==i.cardData:
				pass
			else:
				tips.更新当前Tps(i.cardData)
			pass
	
	%"金币Label".text="金币:%s/%s"%[player.当前金币,player.当前金币上限]
	pass

func 初始化(player:Player):
	self.player=player
	self.player.操作中添加卡片信号.connect(_添加卡片.bind())
	self.player.操作中删除卡片信号.connect(_删除卡片.bind())
	
	_初始化容器(player,Enums.CardPosition.酒馆)
	_初始化容器(player,Enums.CardPosition.手牌)
	_初始化容器(player,Enums.CardPosition.战场)
	pass

func _初始化容器(player:Player,所在位置:Enums.CardPosition):
	var temp
	var card_list
	if 所在位置==Enums.CardPosition.酒馆:
		temp=酒馆
		card_list=player.酒馆
	elif 所在位置==Enums.CardPosition.手牌:
		temp=手牌
		card_list=player.手牌
	elif 所在位置==Enums.CardPosition.战场:
		temp=战场
		card_list=player.战场
	else:
		printerr("错误了")
		print_stack()
	temp.player=player
	for i in temp.容器.get_children():
		i.queue_free()
	for i:CardEntity in card_list:
		i.player=self.player
		i.信号绑定()
		_添加卡片(i,所在位置,-1)
	pass

func _删除卡片(
	d:CardEntity,
	cardPosition:Enums.CardPosition,
):
	if cardPosition==Enums.CardPosition.酒馆:
		for i in 酒馆.获取所有的拖拽象():
			if i is CardUI:
				if i.cardData==d:
					i.queue_free()
		return
	if cardPosition==Enums.CardPosition.手牌:
		for i in 手牌.获取所有的拖拽象():
			if i is CardUI:
				if i.cardData==d:
					i.queue_free()
		return
	if cardPosition==Enums.CardPosition.战场:
		for i in 战场.获取所有的拖拽象():
			if i is CardUI:
				if i.cardData==d:
					i.queue_free()
		return
	printerr("错误删除卡片",d,cardPosition)
	print_stack()
	pass
	
	
func _添加卡片(
	d:CardEntity,
	cardPosition:Enums.CardPosition,
	index:int
):
	if cardPosition==Enums.CardPosition.酒馆:
		# 初始ui
		var cardUI=_获取CardUI(d)
		酒馆.只添加到容器中(cardUI,index)
		return
	if cardPosition==Enums.CardPosition.手牌:
		# 初始ui
		var cardUI=_获取CardUI(d)
		手牌.只添加到容器中(cardUI,index)
		return
	if cardPosition==Enums.CardPosition.战场:
		#if player.是否在战斗中():
			#player.fightUI.添加卡片(player,d,index)
		#else:
		var cardUI=_获取CardUI(d)
		战场.只添加到容器中(cardUI,index)
		return
	printerr("错误添加卡片",d,cardPosition)
	print_stack()

func _获取CardUI(d:CardEntity)->CardUI:
	var cardUI
	if d.get_cardUI() is CardUI:
		return d.get_cardUI()
	else:
		return CardUI.build(d)


func _on_结束回合_pressed() -> void:
	# 结束回合前，将战场中的顺序更新
	player.战场.clear()
	for i in 战场.获取所有的拖拽象():
		player.战场.append(i.cardData)
	结束回合信号.emit()
	pass # Replace with function body.


func _on_刷新酒馆_pressed() -> void:
	player.酒馆刷新(true)
	pass # Replace with function body.
