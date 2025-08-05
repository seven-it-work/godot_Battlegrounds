extends Node
class_name Roar

@export var 触发卡:BaseMinion

func 战吼执行():
	_具体战吼方法接口()
	触发卡.player.战吼触发信号.emit(触发卡)

## 由子类实现
func _具体战吼方法接口():
	pass
