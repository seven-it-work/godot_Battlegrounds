extends Control

func _ready() -> void:
	#$BackpackUi.添加物品($"SubViewport/物品")
	#$BackpackUi.添加物品($"SubViewport/物品2")
	
	for i in 101:
		var 物品=preload("res://背包系统/test/物品.tscn").instantiate()
		物品.uuid=randi_range(0, 100)
		物品.名称="测"+str(i)
		$BackpackUi.添加物品(物品)
	pass
