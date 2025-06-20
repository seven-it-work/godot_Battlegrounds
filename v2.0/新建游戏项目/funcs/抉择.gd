extends Node
class_name Choose

@onready var 抉择选项ui=$MarginContainer

func 是否需要选择目标()->bool:
	var target=get_node("TargetSelector")
	if target:
		return target.是否需要选择目标
	return false
	
func 选择目标筛选方法(list:Array)->Array:
	var target=get_node("TargetSelector")
	if target:
		return target.筛选方法(list)
	return list

func 获取抉择选项()->Array[ChooseOption]:
	return $MarginContainer/GridContainer.get_children().filter(func(node): return node is ChooseOption)
