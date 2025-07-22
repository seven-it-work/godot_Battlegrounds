extends ItemUI

@export var 名称:String=""
var uuid:int=0

func 判断是否为同一物品(itemUI:ItemUI)->bool:
	return itemUI.uuid==uuid

func 获取物品数据():
	return self

func _ready() -> void:
	$Label.text=名称
	pass
