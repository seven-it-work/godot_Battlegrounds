extends Control

func _ready() -> void:
	CardUtils.游戏初始化加载卡牌([])
	$Player.战场.append(CardUtils.get_card("沙丘土著",$Player))
	$Player2.战场.append(CardUtils.get_card("南海卖艺者",$Player2))
	$FightUi.开始战斗($Player,$Player2)
