extends GutTest

const uid="uid://r6yr6b6j7nj5"

func _ready() -> void:
	for i in 6:
		var card=preload(uid).instantiate()
		$"测试基础战斗/玩家".战场.添加到容器中(Global.创建新卡片(card,$"测试基础战斗/玩家"),-1)
	$"测试基础战斗/玩家".战场.添加到容器中(Global.创建新卡片(preload("uid://cptuaedglysg3").instantiate(),$"测试基础战斗/玩家"),-1)
	for i in 6:
		var card=preload(uid).instantiate()
		$"测试基础战斗/敌人".战场.添加到容器中(Global.创建新卡片(card,player),-1)
	$"测试基础战斗/敌人".战场.添加到容器中(Global.创建新卡片(preload("uid://cptuaedglysg3").instantiate()),-1)
		
	$"测试基础战斗/fight".开始战斗($"测试基础战斗/玩家",$"测试基础战斗/敌人")
	pass


func _on_测试基础战斗_战斗结束信号() -> void:
	var player=$"测试基础战斗/玩家"
	var card=$"测试基础战斗/玩家".获取战场中的牌().get(6) 
