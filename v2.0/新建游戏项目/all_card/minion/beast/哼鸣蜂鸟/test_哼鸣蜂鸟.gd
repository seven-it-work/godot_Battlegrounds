extends GutTest

func _ready() -> void:
	for i in 7:
		var card=preload("uid://ddhd6mtmsxu8i").instantiate()
		$"测试基础战斗/玩家".战场.添加到容器中(Global.创建新卡片(card),-1)
	
	
	for i in 7:
		var card=preload("uid://ddhd6mtmsxu8i").instantiate()
		$"测试基础战斗/敌人".战场.添加到容器中(Global.创建新卡片(card),-1)
		
	$"测试基础战斗/fight".开始战斗($"测试基础战斗/玩家",$"测试基础战斗/敌人")
	pass


func _on_测试基础战斗_战斗结束信号() -> void:
	var list=$"测试基础战斗/玩家".野兽加成
	print(list)
	pass # Replace with function body.
