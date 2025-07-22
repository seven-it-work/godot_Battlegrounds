extends BackPackTipsUI

# 由子类去扩展
func 更新信息(itemUI:ItemUI):
	$Label.text="这是我的自定义信息："+itemUI.名称
	pass


func 清空信息():
	$Label.text=""
	pass
