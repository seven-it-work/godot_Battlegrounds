extends Node
class_name Roar

@export var 执行的卡牌:BaseMinion

func 战吼执行():
	_具体战吼方法接口()
	执行的卡牌.player.战吼触发信号.emit(执行的卡牌)

## 由子类实现
func _具体战吼方法接口():
	pass
