extends BaseMinion

@export var 战吼:Array[Roar]=[]

func _ready():
	var roar_node = Roar.new()
	add_child(roar_node)
	roar_node.触发卡 = self
	roar_node.script = preload("res://所有卡牌/随从/龙/活跃的奇想幼龙/活跃的奇想幼龙_Roar.gd")
	战吼.append(roar_node)
