extends HBoxContainer

signal 取消
signal 确定

func _on_取消_pressed() -> void:
	Globals.main_node.选择的cardUi.disable=false
	Globals.main_node.选择的cardUi=null
	取消.emit()
	pass # Replace with function body.


func _on_确定_pressed() -> void:
	Globals.main_node.选择的继续运行方法.call(Globals.main_node.select_card)
	Globals.main_node.选择的cardUi=null
	确定.emit()
	pass # Replace with function body.
