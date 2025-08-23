extends Control

func _ready() -> void:
	$"操作回合".初始化($Player)
	CardUtils.游戏初始化加载卡牌([])
	pass


func _on_操作回合_结束回合信号() -> void:
	$"操作回合".hide()
	$FightUi.show()
	var 敌人=Player.new()
	敌人.名称="测试敌人"
	
	敌人.添加卡片(CardUtils.get_card("魔刃豹",敌人),Enums.CardPosition.战场,-1,true)
	敌人.添加卡片(CardUtils.get_card("魔刃豹",敌人),Enums.CardPosition.战场,-1,true)
	敌人.添加卡片(CardUtils.get_card("魔刃豹",敌人),Enums.CardPosition.战场,-1,true)
	敌人.添加卡片(CardUtils.get_card("魔刃豹",敌人),Enums.CardPosition.战场,-1,true)
	敌人.添加卡片(CardUtils.get_card("魔刃豹",敌人),Enums.CardPosition.战场,-1,true)
	敌人.添加卡片(CardUtils.get_card("魔刃豹",敌人),Enums.CardPosition.战场,-1,true)
	敌人.添加卡片(CardUtils.get_card("饥饿的钳嘴龟",敌人),Enums.CardPosition.战场,-1,true)
	
	$FightUi.开始战斗($Player,敌人)
	pass # Replace with function body.
