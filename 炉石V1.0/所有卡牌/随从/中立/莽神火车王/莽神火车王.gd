extends BaseMinion

@export var 亡语:Array[Deathrattle]=[]
var _killer: BaseMinion = null

func _ready():
	var deathrattle_node = Deathrattle.new()
	add_child(deathrattle_node)
	deathrattle_node.触发卡 = self
	deathrattle_node.script = preload("res://所有卡牌/随从/中立/莽神火车王/莽神火车王_Deathrattle.gd")
	亡语.append(deathrattle_node)

func 生命扣除(攻击者: CardEntity, 伤害值: int):
	_killer = 攻击者 as BaseMinion # Store the killer
	await super.生命扣除(攻击者, 伤害值)
