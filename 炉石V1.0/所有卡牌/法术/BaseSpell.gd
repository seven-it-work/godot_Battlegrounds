extends CardEntity
class_name BaseSpell

func _init() -> void:
	卡牌类型=Enums.CardType.法术

## 由子类实现
func 法术使用处理():
	pass
