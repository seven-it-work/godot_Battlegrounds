extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(7):
		var card = preload("uid://dr3w1srvxktsy").instantiate()
		$HBoxContainer/VBoxContainer/Tavern/Cards.add_card(card)
		$HBoxContainer/VBoxContainer/CardList/Cards.add_card(preload("uid://dr3w1srvxktsy").instantiate())
	$HBoxContainer/VBoxContainer/Tavern/Cards.draged_out.connect(酒馆卡牌拖拽出界)

func _process(delta: float) -> void:
	var cardList:PanelContainer=$HBoxContainer/VBoxContainer/CardList
	if !$HBoxContainer/VBoxContainer/Tavern/Cards._draged_card:
		var style:StyleBoxFlat=cardList.get_theme_stylebox("panel")
		style.border_color=Color(0.898, 0.792, 0.102,0.0)
		cardList.add_theme_stylebox_override("panel",style)
		$HBoxContainer/VBoxContainer/Tavern/Cards.准备购买(null)
	else:
		var style:StyleBoxFlat=cardList.get_theme_stylebox("panel")
		style.border_color=Color(0.898, 0.792, 0.102)
		cardList.add_theme_stylebox_override("panel",style)
		

func 酒馆卡牌拖拽出界(card:BaseDragableCard):
	var mp = get_global_mouse_position()
	var cardList:PanelContainer=$HBoxContainer/VBoxContainer/CardList
	if mp.x>cardList.global_position.x and mp.x<=cardList.global_position.x +cardList.size.x:
		if mp.y>cardList.global_position.y and mp.y<=cardList.global_position.y +cardList.size.y:
			$HBoxContainer/VBoxContainer/Tavern/Cards.准备购买(card)

	#if mp.y>get_rect().size.y+get_rect().position.y:
		#draged_out.emit(_draged_card)
		#return
	#if mp.y<get_rect().size.y+get_rect().position.y-_draged_card.size.y:
		#draged_out.emit(_draged_card)
		#return
	pass
