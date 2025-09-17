extends BaseMinion

@export var DuoGameExclusive:bool = true
@export var 塑造法术:Array[BaseSpell]=[]

func _ready():
	var spellcraft_node = BaseSpell.new()
	add_child(spellcraft_node)
	spellcraft_node.name = "Spellcraft"
	spellcraft_node.script = preload("res://所有卡牌/随从/野兽/私房主厨/私房主厨_Spellcraft.gd")
	spellcraft_node.lushi_id = lushi_id
	spellcraft_node.str_id = str_id
	spellcraft_node.名称 = "选择随从"
	spellcraft_node.描述 = "选择一张随从牌。获取一张同类型的牌并传递给你的队友。"
	spellcraft_node.is_gold = is_gold
	塑造法术.append(spellcraft_node)
