extends BaseMinion

@export var 战吼:Array[Roar]=[]
var _dead_minions_last_combat: int = 0

func _ready():
	var roar_node = Roar.new()
	add_child(roar_node)
	roar_node.触发卡 = self
	roar_node.script = preload("res://所有卡牌/随从/亡灵/壳中小精灵/壳中小精灵_Roar.gd")
	战吼.append(roar_node)

func 信号绑定():
	player.战斗结束信号.connect(_on_战斗结束) # Assuming this signal exists

func _on_战斗结束():
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	# 统计上一场战斗中死亡的友方随从数量
	_dead_minions_last_combat = player.获取上一场战斗死亡随从数量() # Placeholder
