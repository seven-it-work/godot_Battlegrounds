extends Control

var player:Player
func _ready() -> void:
	player=$Player
	$"操作回合".初始化(player)
	CardUtils.游戏初始化加载卡牌([])
	pass


func _on_button_pressed() -> void:
	var t=preload("uid://x8dgikce8axj").instantiate()
	var ts=t.scene_file_path
	var ps=Player.new().scene_file_path
	var t_s=t.get_script() as Script
	var t_p=t_s.get_path()
	var t_c=t_s.can_instantiate()
	var p_c=Player.new().get_script().can_instantiate()
	#var card=CardUtils.get_card("愤怒编织者",$Player)
	#var card=CardUtils.get_card("熔融岩石",$Player)
	var card=CardUtils.get_card("剃刀沼泽地卜师",player)
	player.添加卡片(card,Enums.CardPosition.酒馆,-1,true)
	pass # Replace with function body.


func _on_读档_pressed() -> void:
	player.free()
	var obj=JSON.to_native(JSON.parse_string(temp_json), true)
	player=obj
	$"操作回合".初始化(player)
	pass # Replace with function body.

var temp_json=""
func _on_存档_pressed() -> void:
	player.save_json()
	var json=JSON.stringify(JSON.from_native(player, true))
	temp_json=json
	print(temp_json)
	pass # Replace with function body.
