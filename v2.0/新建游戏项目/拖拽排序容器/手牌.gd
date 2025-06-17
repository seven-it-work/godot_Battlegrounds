extends DragContainer


func _on_进入容器并释放(拖拽:DragControl,进入的容器:Control) -> void:
	# 这里就可以操作很多东西，而且没有处理
	if 拖拽 is DragOrArrowControl:
		拖拽.是否出现箭头=true
		pass
	print("使用")
	pass # Replace with function body.
