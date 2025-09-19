extends BaseMinion

@export var 亡语:Array[Deathrattle]=[]

func _ready():
	var deathrattle_node = Deathrattle.new()
	add_child(deathrattle_node)
	deathrattle_node.触发卡 = self
	deathrattle_node.script = preload("res://所有卡牌/随从/恶魔/影舞者/影舞者_Deathrattle.gd")
	亡语.append(deathrattle_node)
