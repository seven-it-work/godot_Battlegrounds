extends CardData
func get_desc(player:Player,otherJson:Dictionary={})->String:
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	otherJson.set("法术攻击值",3+合计加成.atk)
	otherJson.set("法术生命值",3+合计加成.hp)
	return super.get_desc(player,otherJson)
	
func 使用触发(player:Player):
	super.使用触发(player)
	if $"使用时是否需要选择目标".目标对象:
		# 如果目标存在类型
		var cardData= $"使用时是否需要选择目标".目标对象.card_data as CardData
		var 合计加成=AttributeBonus.计算总和(player.法术加成)
		cardData.atk_process(self.get_parent(),3+合计加成.atk,player)
		cardData.hp_process(self.get_parent(),3+合计加成.hp,player)
		if cardData.是否属于种族(Enums.RaceEnum.NAGA):
			cardData.atk_process(self.get_parent(),3,player)
			cardData.hp_process(self.get_parent(),3,player)
