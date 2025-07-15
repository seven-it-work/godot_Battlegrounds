extends Node2D
@export var people:BasePeople

func _process(delta: float) -> void:
	if people:
		$Label.text=people.name_str
		$Area2D/CollisionShape2D.shape.size=$Label.size
