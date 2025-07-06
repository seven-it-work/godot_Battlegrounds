extends Node
class_name TargetSelector

@export var 是否需要选择目标:bool=true
var 目标对象:Card=null

func 筛选方法(list:Array[CardUI])->Array[CardUI]:
	print("默认的筛选方法")
	return list
