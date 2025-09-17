extends BaseMinion

@export var 复生:bool = true
@export var 亡语:Array[Deathrattle]=[]

func _ready():
	var deathrattle_node = Deathrattle.new()
	add_child(deathrattle_node)
	deathrattle_node.触发卡 = self
	deathrattle_node.script = preload("res://所有卡牌/随从/亡灵/死亡管家莫罗斯/死亡管家莫罗斯_Deathrattle.gd")
	亡语.append(deathrattle_node)
