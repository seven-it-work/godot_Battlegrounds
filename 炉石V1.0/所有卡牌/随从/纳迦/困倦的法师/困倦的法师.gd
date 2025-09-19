extends BaseMinion

@export var 塑造法术:Array[BaseSpell]=[]

func _ready():
	var spellcraft_node = BaseSpell.new()
	add_child(spellcraft_node)
	spellcraft_node.name = "Spellcraft"
	spellcraft_node.script = preload("res://所有卡牌/随从/纳迦/困倦的法师/困倦的法师_Spellcraft.gd")
	spellcraft_node.lushi_id = lushi_id
	spellcraft_node.str_id = str_id
	spellcraft_node.名称 = "增强随从"
	spellcraft_node.描述 = "选择一张随从牌。使其获得+2/+2。如果是纳迦，则额外获得复生。"
	spellcraft_node.is_gold = is_gold
	塑造法术.append(spellcraft_node)
