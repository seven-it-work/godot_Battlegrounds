extends Panel
class_name Choose

@onready var 抉择选项ui=$MarginContainer
var 上一次选项:ChooseOption=null
var player:Player

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
	var list:Array[ChooseOption]=[]
	for i in $MarginContainer/GridContainer.get_children():
		if i is ChooseOption:
			list.append(i)
	return list

func 选中样式改变(选项:ChooseOption):
	if self.上一次选项==null:
		self.上一次选项=选项
		self.上一次选项.样式选中()
	else:
		if 上一次选项==self:
			pass
		else:
			self.上一次选项.清理选中样式()
			self.上一次选项=选项
			self.上一次选项.样式选中()


func _on_隐藏_pressed() -> void:
	self.hide()
	pass # Replace with function body.


func _on_确定_pressed() -> void:
	#if self.上一次选项:
		#var p=get_parent()
		#上一次选项.执行方法(player,get_parent())
		#self.hide()
	#else:
		#print("没有选择")
	pass # Replace with function body.
