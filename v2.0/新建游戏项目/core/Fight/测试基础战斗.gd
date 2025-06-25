extends Control

func _ready() -> void:
	for i in 2:
		var drag=preload("uid://c1wvxhubccoqe").instantiate()
		drag.card_data=preload("uid://b3a4qbmde2b03").instantiate()
		drag.add_child(drag.card_data)
		drag.uuid=drag.card_data.uuid
		$"玩家".战场.添加到容器中(drag,-1)
	
	
	for i in 2:
		var drag=preload("uid://c1wvxhubccoqe").instantiate()
		drag.card_data=preload("uid://cirqyt3sqmpq8").instantiate()
		drag.add_child(drag.card_data)
		drag.uuid=drag.card_data.uuid
		$"敌人".战场.添加到容器中(drag,-1)
		
	$fight.开始战斗($"玩家",$"敌人")
	pass


func _on_fight_战斗结束(胜利者: RefCounted, 失败者: RefCounted, 造成伤害: int) -> void:
	print("战斗完成了")
	if 造成伤害==0:
		print("平局")
	else:
		print("胜利者",胜利者)
	$fight.是否战斗完成标志=true
	pass # Replace with function body.
