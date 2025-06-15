extends DragContainer


func _on_拖拽到其他容器(card:DragCard,container) -> void:
	print("出售随从")
	var player=Globals.main_node.player as Player
	player.出售随从(card)
	card.queue_free()
	pass # Replace with function body.
