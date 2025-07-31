extends Node
class_name FightPlayer

var player:Player
var 当前攻击的随从:BaseMinionCard

func _init(player:Player) -> void:
	self.player=player
