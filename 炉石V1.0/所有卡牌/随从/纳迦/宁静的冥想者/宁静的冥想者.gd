extends BaseMinion

@export var 塑造法术:Array[BaseSpell]=[]

func _ready():
	var spellcraft_node = BaseSpell.new()
	add_child(spellcraft_node)
	spellcraft_node.name = "Spellcraft"
	spellcraft_node.script = preload("res://所有卡牌/随从/纳迦/宁静的冥想者/宁静的冥想者_Spellcraft.gd")
	spellcraft_node.lushi_id = lushi_id
	spellcraft_node.str_id = str_id
	spellcraft_node.名称 = "增强酒馆法术"
	spellcraft_node.描述 = "在本局对战中，你的酒馆法术使随从额外获得+1生命值。"
	spellcraft_node.is_gold = is_gold
	塑造法术.append(spellcraft_node)
