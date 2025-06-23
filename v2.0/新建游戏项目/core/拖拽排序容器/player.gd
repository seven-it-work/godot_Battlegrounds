extends Control
class_name Player

@onready var 酒馆:DragContainer=$"VBoxContainer/酒馆"
@onready var 战场:DragContainer=$"VBoxContainer/战场"
@onready var 手牌:DragContainer=$"VBoxContainer/手牌"

var 抉择是否隐藏:bool=false
var 抉择节点:Choose

#region 一些特定的属性
var 优势压制:bool=false
var 分享关爱:bool=false
var 吞饮粘浆:CardData=null

var 元素酒馆加成:Array[AttributeBonus]=[]
#endregion

func 是否在战斗中()->bool:
	return false

func _process(delta: float) -> void:
	$"Panel".visible=抉择是否隐藏

func 获取所有的牌()->Array[DragControl]:
	var all=获取战场和酒馆中的牌()
	all.append_array(手牌.获取所有节点())
	return all

func 获取战斗中的牌()->Array[DragControl]:
	return []

func 获取战场和酒馆中的牌()->Array[DragControl]:
	var all=[]
	all.append_array(酒馆.获取所有节点())
	all.append_array(战场.获取所有节点())
	return all

func 所有的拖拽禁用或者开启(是否开启:bool):
	酒馆.是否可以拖拽=是否开启
	战场.是否可以拖拽=是否开启
	手牌.是否可以拖拽=是否开启
	for i in 获取所有的牌():
		i.容器中是否可以拖拽=是否开启

func _ready() -> void:
	Global.main_node=self
	for i in 2 :
		var drag=preload("uid://c1wvxhubccoqe").instantiate()
		drag.card_data=preload("uid://bjhqpg4a8wuqj").instantiate()
		drag.add_child(drag.card_data)
		$"VBoxContainer/酒馆".添加到容器中(drag,-1)
	for i in 2 :
		var drag=preload("uid://c1wvxhubccoqe").instantiate()
		drag.card_data=preload("uid://b3a4qbmde2b03").instantiate()
		drag.add_child(drag.card_data)
		$"VBoxContainer/酒馆".添加到容器中(drag,-1)
	for i in 2 :
		var drag=preload("uid://c1wvxhubccoqe").instantiate()
		drag.card_data=preload("uid://cuxpxje8iycj3").instantiate()
		drag.add_child(drag.card_data)
		$"VBoxContainer/酒馆".添加到容器中(drag,-1)
	pass

func 获取当前酒馆等级()->int:
	return 1;

func _on_抉择是否隐藏_pressed() -> void:
	抉择是否隐藏=false
	if 抉择节点:
		抉择节点.show()
	pass # Replace with function body.

func 添加到手牌(card:CardData):
	var dragControl:DragControl=preload("uid://c1wvxhubccoqe").instantiate()
	dragControl.card_data=card
	dragControl.add_child(card)
	手牌.添加到容器中(dragControl,-1)
	pass
