extends Control

func _ready() -> void:
	CardUtils.游戏初始化加载卡牌([])
	$Player.战场.append(CardUtils.get_card("躁动欺诈者",$Player))
	$Player.战场.append(CardUtils.get_card("躁动欺诈者",$Player))
	
	$Player2.战场.append(CardUtils.get_card("躁动欺诈者",$Player2))
	$Player2.战场.append(CardUtils.get_card("躁动欺诈者",$Player2))
	$FightUi.开始战斗($Player,$Player2)
