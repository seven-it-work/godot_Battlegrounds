extends BaseMinion

@export var DuoGameExclusive:bool = true
@export var 塑造法术:Array[Spellcraft]=[]

func _ready():
	var spellcraft_node = Spellcraft.new()
	add_child(spellcraft_node)
	spellcraft_node.触发卡 = self
	spellcraft_node.script = preload("res://所有卡牌/随从/中立/井边许愿者/井边许愿者_Spellcraft.gd")
	塑造法术.append(spellcraft_node)
