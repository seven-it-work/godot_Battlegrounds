extends Control
class_name MainNode

static var global:MainNode

@export var zongMen:ZongMen

func _ready() -> void:
	MainNode.global=self
	
	for i in $"UI/VBoxContainer/核心面板/TabBar/建造/GridContainer".get_children():
		i.queue_free()
	for i in $"data/默认数据/建筑".get_children():
		var 建筑UI=preload("uid://bgn3gr517oeht").instantiate()
		建筑UI.初始化(i)
		建筑UI.构建.connect(建造建筑.bind(i))
		$"UI/VBoxContainer/核心面板/TabBar/建造/GridContainer".add_child(建筑UI)
	
	pass

func 建造建筑(build:Build):
	print("构建建筑",build)
	pass

func _process(delta: float) -> void:
	if zongMen:
		pass
	pass
