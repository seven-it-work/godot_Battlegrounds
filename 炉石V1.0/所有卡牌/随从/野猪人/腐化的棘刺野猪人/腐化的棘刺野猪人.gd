extends BaseMinion

@export var 亡语:Array[Deathrattle]=[]

func _ready():
	var deathrattle_node = Deathrattle.new()
	add_child(deathrattle_node)
	deathrattle_node.触发卡 = self
	deathrattle_node.script = preload("res://所有卡牌/随从/野猪人/腐化的棘刺野猪人/腐化的棘刺野猪人_Deathrattle.gd")
	亡语.append(deathrattle_node)
