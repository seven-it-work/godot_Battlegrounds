extends BaseMinion

@export var 亡语:Array[Deathrattle]=[]
var _avenge_count: int = 0
var _avenge_threshold: int = 1
var _beast_buff_value: int = 0

func _ready():
	var deathrattle_node = Deathrattle.new()
	add_child(deathrattle_node)
	deathrattle_node.触发卡 = self
	deathrattle_node.script = preload("res://所有卡牌/随从/野兽/异种钻地虫/异种钻地虫_Deathrattle.gd")
	亡语.append(deathrattle_node)

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
	var buff_increase: int = 1
	if is_gold:
		buff_increase = 2
	_beast_buff_value += buff_increase
