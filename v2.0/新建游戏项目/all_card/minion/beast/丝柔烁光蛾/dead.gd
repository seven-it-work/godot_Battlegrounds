extends Dead

func 亡语(攻击者:CardData,player:Player):
	#召唤甲虫
	var card=preload("uid://clurlnso3urhr").instantiate()
	var 总和=AttributeBonus.计算总和(player.甲虫加成)
	card.atk+=总和.atk
	card.hp+=总和.hp
	var index=亡语者.get_parent().get_index()
	player.添加随从(card,index+1)
	pass
