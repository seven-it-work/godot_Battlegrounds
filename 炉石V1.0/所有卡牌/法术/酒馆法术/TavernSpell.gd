extends BaseSpell
class_name TavernSpell

@export var 是否扣除的是生命值:bool=false

func _init() -> void:
	卡牌类型=Enums.CardType.酒馆法术

func 获取花费()->int:
	return max(0,花费-player.下次购买法术金币减少数量)
