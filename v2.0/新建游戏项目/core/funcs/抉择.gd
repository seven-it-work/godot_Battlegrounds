extends Panel
class_name Choose

@onready var 抉择选项ui=$MarginContainer
var 上一次选项:ChooseOption=null

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

func 选中样式改变(选项:ChooseOption):
	if 上一次选项==null:
		上一次选项=选项
		上一次选项.样式选中()
	else:
		if 上一次选项==self:
			pass
		else:
			上一次选项.清理选中样式()
			上一次选项=选项
			上一次选项.样式选中()


func _on_隐藏_pressed() -> void:
	Global.main_node.抉择节点=self
	Global.main_node.抉择是否隐藏=true
	self.hide()
	pass # Replace with function body.


func _on_确定_pressed() -> void:
	if 上一次选项:
		print("使用成功")
		self.hide()
	else:
		print("没有选择")
	pass # Replace with function body.
