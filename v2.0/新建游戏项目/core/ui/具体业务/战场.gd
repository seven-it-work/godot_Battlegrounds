extends "res://core/ui/card_sort_container.gd"


func _on_在其他容器中释放() -> void:
	当前拖拽中的卡片.hide()
	当前拖拽中的卡片.queue_free()
	pass # Replace with function body.
