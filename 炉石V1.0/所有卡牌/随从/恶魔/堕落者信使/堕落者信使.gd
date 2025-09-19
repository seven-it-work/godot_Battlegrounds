extends BaseMinion

@export var DuoGameExclusive:bool = true
@export var 战吼:Array[Roar]=[]

func _ready():
	var roar_node = Roar.new()
	add_child(roar_node)
	roar_node.触发卡 = self
	roar_node.script = preload("res://所有卡牌/随从/恶魔/堕落者信使/堕落者信使_Roar.gd")
	战吼.append(roar_node)
