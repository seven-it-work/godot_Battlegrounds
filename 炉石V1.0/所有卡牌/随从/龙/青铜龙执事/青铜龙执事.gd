extends BaseMinion

@export var 战吼:Array[Roar]=[]
@export var 亡语:Array[Deathrattle]=[]

func _ready():
	_load_battlecry_effect()
	_load_deathrattle_effect()

func _load_battlecry_effect():
	var roar_node = Roar.new()
	add_child(roar_node)
	roar_node.触发卡 = self
	roar_node.script = preload("res://所有卡牌/随从/龙/青铜龙执事/青铜龙执事_Roar.gd")
	战吼.append(roar_node)

func _load_deathrattle_effect():
	var deathrattle_node = Deathrattle.new()
	add_child(deathrattle_node)
	deathrattle_node.触发卡 = self
	deathrattle_node.script = preload("res://所有卡牌/随从/龙/青铜龙执事/青铜龙执事_Deathrattle.gd")
	亡语.append(deathrattle_node)
