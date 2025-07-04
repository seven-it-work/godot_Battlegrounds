extends CardData
#使一个随从获得+{0}/+{1}和<b>嘲讽</b>。如果它已经拥有<b>嘲讽</b>，则移除。

var base_atk=1;
var base_hp=2;

func get_desc(player:Player,otherJson:Dictionary={})->String:
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	otherJson.set("法术攻击值",base_atk+合计加成.atk)
	otherJson.set("法术生命值",base_hp+合计加成.hp)
	return super.get_desc(player,otherJson)
	
func 使用触发(player:Player):
	super.使用触发(player)
	if $"使用时是否需要选择目标".目标对象:
		# 如果目标存在类型
		var cardData= $"使用时是否需要选择目标".目标对象.card_data as CardData
		var 合计加成=AttributeBonus.计算总和(player.法术加成)
		var attri=get_AttributeBonus()
		attri.atk=base_atk+合计加成.atk
		attri.hp=base_hp+合计加成.hp
		cardData.属性添加(self,player,attri)
		if cardData.嘲讽:
			cardData.是否被取消嘲讽=true
		else:
			cardData.嘲讽=true
