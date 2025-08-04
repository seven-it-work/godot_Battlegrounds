extends Node
class_name Roar

func 战吼执行():
	_具体战吼方法接口()
	var 触发卡片=get_parent() as BaseMinion
	触发卡片.player.战吼触发信号.emit(触发卡片)

## 由子类实现
func _具体战吼方法接口():
	pass
