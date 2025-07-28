extends Node
class_name PeopleWork

@export var 名称:String
@export var value:int=0
@export var value_max:int=0
@export var disable:bool=false
@export var disc:String=""

func 获取描述()->String:
	return disc

func 添加(num:int):
	value=min(value+num,value_max)

func _to_string() -> String:
	return str(ObjectUtils.get_exported_properties(self))
