extends GutTest

const uid="uid://mhrw4kfmgpvu"
var test:CardData
func _ready() -> void:
	for i in 6:
		var card=preload(uid).instantiate()
		$"测试基础战斗/玩家".战场.添加到容器中(Global.创建新卡片(card,$"测试基础战斗/玩家"),-1)
	test=preload("uid://dwga80qi3r6f0").instantiate()
	$"测试基础战斗/玩家".战场.添加到容器中(Global.创建新卡片(test),-1)
	for i in 6:
		var card=preload(uid).instantiate()
		$"测试基础战斗/敌人".战场.添加到容器中(Global.创建新卡片(card,player),-1)
	$"测试基础战斗/敌人".战场.添加到容器中(Global.创建新卡片(preload("uid://dwga80qi3r6f0").instantiate()),-1)
		
	$"测试基础战斗/fight".开始战斗($"测试基础战斗/玩家",$"测试基础战斗/敌人")
	pass


func _on_测试基础战斗_战斗结束信号() -> void:
	var player=$"测试基础战斗/玩家"
	var list=player.战场.获取所有节点()
	print(test.atk_bonus())
	pass # Replace with function body.
