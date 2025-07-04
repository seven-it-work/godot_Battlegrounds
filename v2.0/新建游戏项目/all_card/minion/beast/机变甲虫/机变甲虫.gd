extends CardData

func 使用触发(player:Player):
	$"抉择".player=player

func _on_抉择选项1_选择信号(选项: ChooseOption) -> void:
	$"抉择".选中样式改变(选项)
	pass # Replace with function body.

func _on_抉择选项2_选择信号(选项: ChooseOption) -> void:
	$"抉择".选中样式改变(选项)
	pass # Replace with function body.

func 执行抉择选项1(player:Player):
	print("抉择选项1")

func 执行抉择选项2(player:Player):
	print("抉择选项2")
