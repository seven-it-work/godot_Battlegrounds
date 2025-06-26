extends ChooseOption

func get_desc(card:DragControl,player:Player,otherJson:Dictionary={})->String:
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	otherJson.set("法术攻击值",card.card_data.base_atk+合计加成.atk)
	otherJson.set("法术生命值",card.card_data.base_hp+合计加成.hp)
	return super.get_desc(card,player,otherJson)

func 执行方法(player:Player,card:DragControl):
	card.card_data.决战执行方法(player,card)
