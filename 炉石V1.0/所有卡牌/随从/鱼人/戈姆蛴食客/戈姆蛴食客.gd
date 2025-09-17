extends BaseMinion

@export var 嘲讽:bool = true
@export var 战吼:Array[Roar]=[]
@export var 亡语:Array[Deathrattle]=[]

func _ready():
	var roar_node = Roar.new()
	add_child(roar_node)
	roar_node.触发卡 = self
	roar_node.script = preload("res://所有卡牌/随从/鱼人/戈姆蛴食客/戈姆蛴食客_Roar.gd")
	战吼.append(roar_node)

	var deathrattle_node = Deathrattle.new()
	add_child(deathrattle_node)
	deathrattle_node.触发卡 = self
	deathrattle_node.script = preload("res://所有卡牌/随从/鱼人/戈姆蛴食客/戈姆蛴食客_Deathrattle.gd")
	亡语.append(deathrattle_node)
