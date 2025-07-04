extends CardData

var base_atk=1;
var base_hp=2;

func get_desc(player:Player,otherJson:Dictionary={})->String:
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	otherJson.set("法术攻击值",base_atk+合计加成.atk)
	otherJson.set("法术生命值",base_hp+合计加成.hp)
	return super.get_desc(player,otherJson)

func 使用触发(player:Player):
	for i in player.酒馆.获取所有节点():
		# 如果目标存在类型
		var cardData= i.card_data as CardData
		var 合计加成=AttributeBonus.计算总和(player.法术加成)
		var attri=get_AttributeBonus()
		attri.atk=base_atk+合计加成.atk
		attri.hp=base_hp+合计加成.hp
		cardData.属性添加(self,player,attri)
