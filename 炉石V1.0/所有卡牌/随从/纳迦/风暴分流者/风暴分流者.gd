extends BaseMinion

@export var DuoGameExclusive:bool = true
@export var _spells_passed_this_turn: int = 0

func 信号绑定():
	player.传递酒馆法术信号.connect(_on_传递酒馆法术) # Assuming this signal exists
	player.开始回合信号.connect(_on_开始回合)

func _on_开始回合():
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	_spells_passed_this_turn = 0 # Reset each turn

func _on_传递酒馆法术(passed_spell: BaseSpell):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	if _spells_passed_this_turn == 0: # 每回合一次
		_spells_passed_this_turn = 1
		_trigger_spell_copy(passed_spell)

func _trigger_spell_copy(original_spell: BaseSpell):
	var copies_to_get: int = 1
	if is_gold:
		copies_to_get = 2

	for i in copies_to_get:
		var spell_copy = CardUtils.get_card(original_spell.名称, player)
		player.添加卡片(spell_copy, Enums.CardPosition.手牌, -1, true)
