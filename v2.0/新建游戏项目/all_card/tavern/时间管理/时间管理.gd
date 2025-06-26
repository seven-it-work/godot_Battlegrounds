extends CardData

var base_atk=2;
var base_hp=2;

func get_desc(player:Player,otherJson:Dictionary={})->String:
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	otherJson.set("法术攻击值",base_atk+合计加成.atk)
	otherJson.set("法术生命值",base_hp+合计加成.hp)
	return super.get_desc(player,otherJson)

func 使用触发(player:Player):
	$"抉择".player=player

func _on_抉择选项_选择信号(选项: ChooseOption) -> void:
	$"抉择".选中样式改变(选项)
	pass # Replace with function body.

func _on_抉择选项2_选择信号(选项: ChooseOption) -> void:
	$"抉择".选中样式改变(选项)
	pass # Replace with function body.

func 决战执行方法(player:Player,card:DragControl):
	for i in player.战场.获取所有节点():
		var cardData= i.card_data as CardData
		var 合计加成=AttributeBonus.计算总和(player.法术加成)
		var attri=card.card_data.get_AttributeBonus()
		attri.atk=base_atk+合计加成.atk
		attri.hp=base_hp+合计加成.hp
		cardData.属性添加(player,attri)
