extends BaseMinion

@export var 嘲讽:bool = true
@export var 塑造法术:Array[BaseSpell]=[]

func _ready():
	var spellcraft_node = BaseSpell.new()
	add_child(spellcraft_node)
	spellcraft_node.name = "Spellcraft"
	spellcraft_node.script = preload("res://所有卡牌/随从/纳迦/闪鳞纳迦/闪鳞纳迦_Spellcraft.gd")
	spellcraft_node.lushi_id = lushi_id
	spellcraft_node.str_id = str_id
	spellcraft_node.名称 = "闪鳞头冠"
	spellcraft_node.描述 = "直到下个回合，使一个随从获得圣盾。"
	spellcraft_node.is_gold = is_gold
	塑造法术.append(spellcraft_node)
