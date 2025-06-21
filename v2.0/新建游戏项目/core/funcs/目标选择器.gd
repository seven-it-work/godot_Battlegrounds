extends Node
class_name TargetSelector

@export var 是否需要选择目标:bool=true
var 目标对象:DragControl=null

func 筛选方法(list:Array)->Array:
	print("默认的筛选方法")
	return list
