extends PeopleWork


func _process(delta: float) -> void:
	if MainNode.global:
		value_max=_获取最大凡人数量()

func _获取最大凡人数量()->int:
	var result=10
	# 后续+住房数量
	return result
