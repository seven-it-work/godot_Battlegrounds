extends Control

var player:Player

func _ready() -> void:
	Globals.main_node=self
	
	var player=preload("uid://duyyralberadj").instantiate()
	player.name_str="测试玩家"
	self.player=player
	
	for i in 3:
		var card=preload("uid://dthisa5oinhjm").instantiate()
		card.baseCard=preload("uid://bd0nd6vjpsrol").instantiate()
		$"拖拽容器".添加卡片(card)
		card.label.text="card_1_%s"%i
		card =preload("uid://dthisa5oinhjm").instantiate()
		$"拖拽容器2".添加卡片(card)
		card.label.text="card_2_%s"%i

func _process(delta: float) -> void:
	if 全局属性:
		if 全局属性.箭头相关属性.是否有拖拽箭头:
			$"箭头".show()
			$"箭头".update_curve(全局属性.箭头相关属性.箭头初始位置,get_global_mouse_position())
		else:
			$"箭头".hide()
	pass
