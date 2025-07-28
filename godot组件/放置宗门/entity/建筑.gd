extends Node
class_name Build

@export var 名称:String=""
@export var description:String=""
@export var 消耗资源:NeedResource
@export var 建筑消耗时间:int=1
@export var lv:int=1


func _to_string() -> String:
	return str(ObjectUtils.get_exported_properties(self))


func 获取描述()->String:
	return description
