extends VBoxContainer

func _process(delta: float) -> void:
	if Globals and  Globals.main_node and Globals.main_node.player:
		var tavern:Tavern=Globals.main_node.player.tavern
		$升级酒馆.text="升级酒馆（%s）"%tavern.升级需要的铸币
		$HBoxContainer/冻结.text="冻结（%s）"%tavern.冻结需要的铸币
		$HBoxContainer/刷新.text="刷新（%s）"%tavern.刷新需要的铸币


func _on_升级酒馆_pressed() -> void:
	Globals.main_node.player.升级()
	pass # Replace with function body.


func _on_冻结_pressed() -> void:
	Globals.main_node.player.冻结()
	pass # Replace with function body.


func _on_刷新_pressed() -> void:
	Globals.main_node.player.刷新()
	pass # Replace with function body.
