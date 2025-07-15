extends PanelContainer
@export var 当前格子:BackpackItem

func _process(delta: float) -> void:
	if 当前格子 and 当前格子.item:
		$HBoxContainer.show()
		var item = 当前格子.item as Item
		$"HBoxContainer/属性1/名称".value=item.item_name
		$"HBoxContainer/属性1/稀有度".value=item.获取品阶名称()
	else:
		$HBoxContainer.hide()
		pass
