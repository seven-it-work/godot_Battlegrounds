extends BaseMinion

@export var 战吼:Array[Roar]=[]

func _ready():
	var roar_node = Roar.new()
	add_child(roar_node)
	roar_node.触发卡 = self
	roar_node.script = preload("res://所有卡牌/随从/亡灵/噬渊施法者/噬渊施法者_Roar.gd")
	战吼.append(roar_node)
