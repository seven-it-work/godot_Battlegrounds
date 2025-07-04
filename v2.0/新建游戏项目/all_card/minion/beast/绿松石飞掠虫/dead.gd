extends Dead
func 执行亡语(攻击者:CardData):
	var 属性=亡语者.get_AttributeBonus()
	属性.atk=1*亡语者.获取是否为金色的倍率()
	属性.hp=2*亡语者.获取是否为金色的倍率()
	亡语者.player.甲虫加成.append(属性)
	for i in 亡语者.获取是否为金色的倍率():
		#召唤甲虫
		var card=preload("uid://clurlnso3urhr").instantiate()
		var 总和=AttributeBonus.计算总和(亡语者.player.甲虫加成)
		card.atk+=总和.atk
		card.hp+=总和.hp
		var index=亡语者.get_parent().get_index()
		亡语者.player.添加随从(card,index+1)
