extends Control
class_name MainNode

static var global:MainNode

@export var zongMen:ZongMen

func _ready() -> void:
	MainNode.global=self
	pass

func _process(delta: float) -> void:
	if zongMen:
		pass
	pass
