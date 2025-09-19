extends BaseMinion

@export var 战吼:Array[Roar]=[]

func _ready():
	var roar_node = Roar.new()
	add_child(roar_node)
	roar_node.触发卡 = self
	roar_node.script = preload("res://所有卡牌/随从/龙/达基萨斯将军/达基萨斯将军_Roar.gd")
	战吼.append(roar_node)
