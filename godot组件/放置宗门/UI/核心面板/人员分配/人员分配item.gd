extends HBoxContainer
@export var peopleWork:PeopleWork

signal 查看详情()

func _process(delta: float) -> void:
	if peopleWork:
		$SpinBox.editable=!peopleWork.disable
		$SpinBox.value=peopleWork.value
		$SpinBox.max_value=peopleWork.value_max
		$SpinBox.prefix="%s："%peopleWork.名称
		pass

func _on_查看详情_pressed() -> void:
	查看详情.emit()
	pass # Replace with function body.


func _on_spin_box_value_changed(value: float) -> void:
	peopleWork.value=value
	pass # Replace with function body.
