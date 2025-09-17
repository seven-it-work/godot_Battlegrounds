extends BaseMinion

@export var _cards_bought_count: int = 0
@export var _cards_bought_threshold: int = 3

func 信号绑定():
	player.购买随从信号.connect(_on_购买随从)

func _on_购买随从(bought_minion: BaseMinion):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return

	_cards_bought_count += 1
	if _cards_bought_count >= _cards_bought_threshold:
		_cards_bought_count = 0 # Reset counter
		_trigger_spell_reward()

func _trigger_spell_reward():
	var spells_to_get: int = 1
	if is_gold:
		spells_to_get = 2

	for i in spells_to_get:
		var tavern_spell = player.获取随机酒馆法术数据() # Placeholder
		if tavern_spell:
			var new_spell = CardUtils.get_card(tavern_spell.nameCN, player)
			player.添加卡片(new_spell, Enums.CardPosition.手牌, -1, true)
