extends Control


func _ready() -> void:
	for i in 7 :
		var drag=preload("uid://448jcf2aiddm").instantiate()
		var l=Label.new()
		l.text="%s"%i
		drag.add_child(l)
		$"酒馆".添加到容器中(drag,-1)
	pass
