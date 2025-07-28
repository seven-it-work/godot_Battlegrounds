extends PeopleWork


func _process(delta: float) -> void:
	if MainNode.global:
		var temp=获取空闲人数()
		value=temp
		value_max=temp

func 获取空闲人数()->int:
	return MainNode.global.zongMen.凡人总人数.value-MainNode.global.zongMen.施工队.value
