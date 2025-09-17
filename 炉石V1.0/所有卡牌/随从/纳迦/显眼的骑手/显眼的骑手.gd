extends BaseMinion

@export var 亡语:Array[Deathrattle]=[]
var _spells_cast_this_game: int = 0
var _naga_buff_value: int = 0

func _ready():
	var deathrattle_node = Deathrattle.new()
	add_child(deathrattle_node)
	deathrattle_node.触发卡 = self
	deathrattle_node.script = preload("res://所有卡牌/随从/纳迦/显眼的骑手/显眼的骑手_Deathrattle.gd")
	亡语.append(deathrattle_node)

func 信号绑定():
	player.使用卡牌信号.connect(_on_使用卡牌)

func _on_使用卡牌(used_card: CardEntity):
	if used_card is BaseSpell: # 施放法术时
		_spells_cast_this_game += 1
		# 每施放4个法术都会提升
		if _spells_cast_this_game % 4 == 0:
			_naga_buff_value += 1
