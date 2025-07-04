extends GutTest
const uid="uid://mhrw4kfmgpvu"
func _ready() -> void:
	for i in 5:
		var card=preload(uid).instantiate()
		$"测试基础战斗/玩家".战场.添加到容器中(Global.创建新卡片(card,$"测试基础战斗/玩家"),-1)
		
	$"测试基础战斗/玩家".战场.添加到容器中(Global.创建新卡片(preload("uid://btmtcpyjh5sae").instantiate(),$"测试基础战斗/玩家"),-1)
	$"测试基础战斗/玩家".战场.添加到容器中(Global.创建新卡片(preload("uid://cptuaedglysg3").instantiate(),$"测试基础战斗/玩家"),-1)
	for i in 5:
		var card=preload(uid).instantiate()
		$"测试基础战斗/敌人".战场.添加到容器中(Global.创建新卡片(card,$"测试基础战斗/敌人"),-1)
	$"测试基础战斗/敌人".战场.添加到容器中(Global.创建新卡片(preload("uid://btmtcpyjh5sae").instantiate(),$"测试基础战斗/敌人"),-1)
	$"测试基础战斗/敌人".战场.添加到容器中(Global.创建新卡片(preload("uid://cptuaedglysg3").instantiate(),$"测试基础战斗/敌人"),-1)
	
	$"测试基础战斗/fight".开始战斗($"测试基础战斗/玩家",$"测试基础战斗/敌人")
	pass
