extends PeopleWork

func 获取描述()->String:
	return "每一个施工人员，建造效率提升0.01%最高不超过70%。当前效率：+"+str(value*0.01)+"%"
	
func _process(delta: float) -> void:
	if MainNode.global:
		value_max=value+MainNode.global.zongMen.空闲人员.value
