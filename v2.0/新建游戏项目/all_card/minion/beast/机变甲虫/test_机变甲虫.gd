extends GutTest

func _ready() -> void:
	var 酒馆=$player.酒馆 as DragContainer
	酒馆.添加到容器中(Global.创建新卡片(preload("uid://b812lc203e882").instantiate()),-1)
	酒馆.添加到容器中(Global.创建新卡片(preload("uid://b812lc203e882").instantiate()),-1)
	pass
