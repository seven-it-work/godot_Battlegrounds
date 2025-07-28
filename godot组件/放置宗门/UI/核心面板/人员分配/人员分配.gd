extends PanelContainer

@onready var 名称:=$"HBoxContainer/Tips/VBoxContainer/名称"
@onready var 描述:=$"HBoxContainer/Tips/VBoxContainer/描述"
@onready var grid:=$HBoxContainer/GridContainer
@export var 当前tips:PeopleWork

func _process(delta: float) -> void:
	if MainNode && MainNode.global:
		if 当前tips:
			名称.text="名称：%s"%当前tips.名称
			描述.text="描述：%s"%当前tips.获取描述()
		var 人员分配数据=MainNode.global.get_node("%人员分配数据")
		if 人员分配数据.get_children().size()!=grid.get_children().size():
			for i in grid.get_children():
				i.queue_free()
			for i in 人员分配数据.get_children():
				var ui=preload('uid://citlmog5mflua').instantiate()
				ui.peopleWork=i
				ui.查看详情.connect(更新Tips.bind(i))
				grid.add_child(ui)
				pass
		
	pass


func 更新Tips(work:PeopleWork):
	当前tips=work
	pass
