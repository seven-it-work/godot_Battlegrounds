extends PanelContainer

func _process(delta: float) -> void:
	if MainNode && MainNode.global:
		$"GridContainer/木材".text="木材：%s"%[MainNode.global.zongMen.木材存量]
		$"GridContainer/凡人数量".text="凡人数量：%s/%s"%[MainNode.global.zongMen.凡人数量,MainNode.global.zongMen.最大凡人数量]
	pass
