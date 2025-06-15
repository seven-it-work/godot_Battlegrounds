extends DragContainer


func _on_拖拽到其他容器(card,dragContainer) -> void:
	print("使用成功")
	var player=Globals.main_node.player as Player
	player.user_card(card.baseCard)
	pass # Replace with function body.
