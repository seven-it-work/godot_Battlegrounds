extends BaseMinion

@export var 嘲讽:bool = true
@export var 亡语:Array[Deathrattle]=[]

func _ready():
	var deathrattle_node = Deathrattle.new()
	add_child(deathrattle_node)
	deathrattle_node.触发卡 = self
	deathrattle_node.script = preload("res://所有卡牌/随从/野兽/威严猛虎/威严猛虎_Deathrattle.gd")
	亡语.append(deathrattle_node)
