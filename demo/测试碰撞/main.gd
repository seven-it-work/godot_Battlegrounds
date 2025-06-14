extends Control


func _ready() -> void:
	for i in 3:
		var card=preload("res://demo/测试碰撞/拖拽卡片.tscn").instantiate()
		$"拖拽容器".添加卡片(card)
		card.label.text="card_1_%s"%i
		card =preload("res://demo/测试碰撞/拖拽卡片.tscn").instantiate()
		$"拖拽容器2".添加卡片(card)
		card.label.text="card_2_%s"%i
