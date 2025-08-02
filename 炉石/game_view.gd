extends Control
class_name GameView

func _ready() -> void:
	$"操作回合".添加卡片(preload("uid://cgag5xssn8n0a").instantiate(),Enums.CardPosition.酒馆)
	$"操作回合".添加卡片(preload("uid://cgag5xssn8n0a").instantiate(),Enums.CardPosition.酒馆)
	pass
	
func 开始战斗():
	# 生产敌人
	$"操作回合".hide()
	$"战斗ui".show()
	$"战斗ui".开始战斗()
	pass
