extends DragContainer


func _on_tavern_酒馆随从变化() -> void:
	for i in $MarginContainer/HBoxContainer.get_children():
		i.queue_free()
	for i in $Tavern.current_card:
		var 卡牌ui=preload("uid://dthisa5oinhjm").instantiate()
		卡牌ui.baseCard=i;
		添加卡片(卡牌ui)
	pass # Replace with function body.
