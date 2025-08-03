extends Control

func _ready() -> void:
	$"操作回合".初始化($Player)
	CardUtils.游戏初始化加载卡牌([])
	pass


func _on_button_pressed() -> void:
	#var card=CardUtils.get_card("愤怒编织者",$Player)
	#var card=CardUtils.get_card("熔融岩石",$Player)
	var card=CardUtils.get_card("剃刀沼泽地卜师",$Player)
	$Player.添加卡片(card,Enums.CardPosition.酒馆,-1,true)
	pass # Replace with function body.
