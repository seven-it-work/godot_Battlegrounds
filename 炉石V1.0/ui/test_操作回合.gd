extends Control

func _ready() -> void:
	$"操作回合".初始化($Player)
	pass

var test_array:Array=[
	preload("uid://mrg14rtomoq").instantiate(),
	preload("uid://ucqd5ywej1vn").instantiate(),
	CardEntity.new()
]
var index=0;

func _on_button_pressed() -> void:
	var card=test_array.get(index)
	index=(index+1)%test_array.size()
	$Player.添加卡片(card,Enums.CardPosition.酒馆,-1,true)
	pass # Replace with function body.
