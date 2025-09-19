extends BaseMinion

@export var 是否为磁力:bool = true
@export var 磁力可以贴加的种族:Array[Enums.CardRace] = [Enums.CardRace.机械]
@export var 亡语:Array[Deathrattle]=[]

func _ready():
	var deathrattle_node = Deathrattle.new()
	add_child(deathrattle_node)
	deathrattle_node.触发卡 = self
	deathrattle_node.script = preload("res://所有卡牌/随从/机械/自动装配机/自动装配机_Deathrattle.gd")
	亡语.append(deathrattle_node)
