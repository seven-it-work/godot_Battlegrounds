extends BaseMinion

var _avenge_count: int = 0
var _avenge_threshold: int = 4

func 信号绑定():
	player.随从死亡信号.connect(_on_随从死亡)

func _on_随从死亡(死亡随从: BaseMinion):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	if 死亡随从.player == player: # Only count friendly minion deaths
		_avenge_count += 1
		if _avenge_count >= _avenge_threshold:
			_avenge_count = 0 # Reset for next trigger
			_trigger_avenge()

func _trigger_avenge():
	var spells_to_get: int = 1
	if is_gold:
		spells_to_get = 2

	for i in spells_to_get:
		# 获取一张宰割
		var butchering_spell = CardUtils.get_card('宰割', player)
		player.添加卡片(butchering_spell, Enums.CardPosition.手牌, -1, true)
