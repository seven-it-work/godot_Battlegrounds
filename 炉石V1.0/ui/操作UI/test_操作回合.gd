extends Control

var player:Player
func _ready() -> void:
	player=$Player
	$"操作回合".初始化(player)
	CardUtils.游戏初始化加载卡牌([])
	pass

var index=0
func _on_button_pressed() -> void:
	var array=[
		"心灵泥魔",
		"躁动欺诈者",
		"塔德",
		"熔岩潜伏者",
		"深海钓客",
		"贝类收藏家",
		"雏龙走私商",
		"瞌睡雏龙",
		"晾膘的游客",
		"挑衅的船工",
		"野猪预言者",
		"晾膘的游客",
		"派对元素",
		"商贩元素",
		"白赚赌徒",
		"尖利箭矢",
		"厄运先知",
		"沙丘土著",
		"沙丘土著",
		"气泡枪手",
		"催眠机器人",
		"催眠机器人",
		"雄斑虎",
		"复活的骑兵",
		"挑食魔犬",
		"愤怒编织者",
		"熔融岩石",
		"剃刀沼泽地卜师",
	]
	var card=CardUtils.get_card(array[index],player)
	index=(index+1)%array.size()
	player.添加卡片(card,Enums.CardPosition.酒馆,-1,true)
	pass # Replace with function body.


func _on_读档_pressed() -> void:
	player.free()
	var obj=JsonUtils.json2Obj(JSON.parse_string(temp_json),{})
	player=obj
	$"操作回合".初始化(player)
	pass # Replace with function body.

var temp_json=""
func _on_存档_pressed() -> void:
	var json=JSON.stringify(JsonUtils.obj2Json(player,{}))
	print(json)
	temp_json=json
	pass # Replace with function body.


func _on_结束回合_pressed() -> void:
	player.结束回合()
	pass # Replace with function body.
