extends DragContainer


func _on_拖拽到其他容器(card:DragCard,dragContainer) -> void:
	print("使用成功")
	var player=Globals.main_node.player as Player
	player.使用卡牌(card)
	pass # Replace with function body.
