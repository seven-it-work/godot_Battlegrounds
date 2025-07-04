extends GutTest
const uid="uid://cxq1xfpdrgm2k"
func _ready() -> void:
	for i in 7:
		var card=preload(uid).instantiate()
		card.is_gold=true
		$"测试基础战斗/玩家".战场.添加到容器中(Global.创建新卡片(card,$"测试基础战斗/玩家"),-1)
	for i in 7:
		var card=preload(uid).instantiate()
		card.is_gold=true
		$"测试基础战斗/敌人".战场.添加到容器中(Global.创建新卡片(card,$"测试基础战斗/敌人"),-1)
	
	$"测试基础战斗/fight".开始战斗($"测试基础战斗/玩家",$"测试基础战斗/敌人")
	pass
