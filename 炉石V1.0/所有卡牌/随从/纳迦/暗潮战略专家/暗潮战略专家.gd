extends BaseMinion

@export var 塑造法术:Array[Spellcraft]=[]

func _ready():
	var spellcraft_node = Spellcraft.new()
	add_child(spellcraft_node)
	spellcraft_node.触发卡 = self
	spellcraft_node.script = preload("res://所有卡牌/随从/纳迦/暗潮战略专家/暗潮战略专家_Spellcraft.gd")
	塑造法术.append(spellcraft_node)
