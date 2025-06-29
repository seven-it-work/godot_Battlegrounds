extends Control


func _ready() -> void:
	for i in 7:
		var card=preload("uid://cptuaedglysg3").instantiate()
		$"玩家".战场.添加到容器中(Global.创建新卡片(card),-1)
	
	
	for i in 7:
		var card=preload("uid://cptuaedglysg3").instantiate()
		$"敌人".战场.添加到容器中(Global.创建新卡片(card),-1)
		
	$fight.开始战斗($"玩家",$"敌人")
	pass
