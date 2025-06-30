extends GutTest

func _ready() -> void:
	var 酒馆=$player.酒馆 as DragContainer
	酒馆.添加到容器中(Global.创建新卡片(preload("uid://cuxpxje8iycj3").instantiate()),-1)
	酒馆.添加到容器中(Global.创建新卡片(preload("uid://cptuaedglysg3").instantiate()),-1)
	pass
