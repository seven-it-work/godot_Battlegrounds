extends CardData

func get_desc(otherJson:Dictionary={})->String:
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	otherJson.set("法术攻击值",20+合计加成.atk)
	otherJson.set("法术生命值",20+合计加成.hp)
	return super.get_desc(player,otherJson)

func 使用触发(player:Player):
	if $"使用时是否需要选择目标".目标对象:
		# 如果目标存在类型
		var cardData= $"使用时是否需要选择目标".目标对象.card_data as CardData
		var 合计加成=AttributeBonus.计算总和(player.法术加成)
		var atk=cardData.atk_bonus()
		var hp=cardData.hp_bonus()
		var attri=get_AttributeBonus()
		attri.atk=合计加成.atk-atk
		attri.hp=合计加成.hp-hp
		cardData.属性添加(self,attri)
