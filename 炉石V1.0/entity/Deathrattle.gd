extends Node
class_name Deathrattle
@export var 触发卡:BaseMinion

func 亡语执行(攻击者:CardEntity):
	_具体亡语方法接口(攻击者)
	触发卡.player.亡语触发信号.emit(触发卡)

## 由子类实现
func _具体亡语方法接口(攻击者:CardEntity):
	pass
