extends CardData

var base_atk1=12;
var base_hp1=12;
var base_atk2=2;
var base_hp2=2;

func _描述json(player:Player,otherJson:Dictionary={})->Dictionary:
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	otherJson.set("法术攻击值1",base_atk1+合计加成.atk)
	otherJson.set("法术生命值1",base_hp1+合计加成.hp)
	otherJson.set("法术攻击值2",base_atk2+合计加成.atk)
	otherJson.set("法术生命值2",base_hp2+合计加成.hp)
	return otherJson

func get_desc(player:Player,otherJson:Dictionary={})->String:
	return super.get_desc(player,_描述json(player,otherJson))

func 使用触发(player:Player):
	$"抉择".player=player

func _on_抉择选项1_选择信号(选项: ChooseOption) -> void:
	$"抉择".选中样式改变(选项)
	pass # Replace with function body.

func _on_抉择选项2_选择信号(选项: ChooseOption) -> void:
	$"抉择".选中样式改变(选项)
	pass # Replace with function body.

func 执行抉择选项1(player:Player):
	if $"使用时是否需要选择目标".目标对象:
		var cardData= $"使用时是否需要选择目标".目标对象.card_data as CardData
		var 合计加成=AttributeBonus.计算总和(player.法术加成)
		var attri=get_AttributeBonus()
		attri.atk=base_atk1+合计加成.atk
		attri.hp=base_hp1+合计加成.hp
		cardData.属性添加(self,player,attri)
	pass

func 执行抉择选项2(player:Player):
	for i in player.战场.获取所有节点():
		var cardData= i.card_data as CardData
		var 合计加成=AttributeBonus.计算总和(player.法术加成)
		var attri=get_AttributeBonus()
		attri.atk=base_atk2+合计加成.atk
		attri.hp=base_hp2+合计加成.hp
		cardData.属性添加(self,player,attri)
