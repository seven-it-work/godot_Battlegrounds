extends DragContainer

func 结束拖拽(拖拽节点:DragControl):
	super.结束拖拽(拖拽节点)
	var 链接=拖拽节点.get_signal_connection_list("结束拖拽")
	pass


func 添加到容器中(拖拽节点:DragControl,index):
	拖拽节点.card_data.所在位置=Enums.CardPosition.酒馆
	super.添加到容器中(拖拽节点,index)
	pass

func _on_在其他容器中释放信号(拖拽: DragControl, 其他容器: DragContainer) -> void:
	其他容器.进入的区域进行释放(拖拽)
	购买触发()
	pass # Replace with function body.


func 购买触发():
	print("购买触发")
	pass
