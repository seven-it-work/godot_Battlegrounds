extends Control

func _ready() -> void:
	var player=Player.new()
	player.名称="玩家"
	$"操作回合".初始化(player)
	CardUtils.游戏初始化加载卡牌([])
	pass


func _on_操作回合_结束回合信号(敌人:Player) -> void:
	$"操作回合".hide()
	$FightUi.show()
	$FightUi.开始战斗($"操作回合".player,敌人)
	pass # Replace with function body.


func _on_fight_ui_战斗结束信号(是否平局: bool, 胜利者: Player, 失败者: Player) -> void:
	$"操作回合".show()
	$FightUi.hide()
	$"操作回合".player.开始回合()
	pass # Replace with function body.
