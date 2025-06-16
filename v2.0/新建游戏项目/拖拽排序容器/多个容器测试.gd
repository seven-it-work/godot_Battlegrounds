extends Control


func _ready() -> void:
	for i in 7 :
		var drag=preload("uid://c1wvxhubccoqe").instantiate()
		drag.区域.append($"拖拽容器2")
		var l=Label.new()
		l.text="%s"%i
		drag.add_child(l)
		$"拖拽容器".添加到容器中(drag,-1)
	for i in 7 :
		var drag=preload("uid://c1wvxhubccoqe").instantiate()
		drag.区域.append($"拖拽容器")
		var l=Label.new()
		l.text="2_%s"%i
		drag.add_child(l)
		$"拖拽容器2".添加到容器中(drag,-1)
	pass
