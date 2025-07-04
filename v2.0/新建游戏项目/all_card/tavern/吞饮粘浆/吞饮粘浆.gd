extends CardData



func 使用触发(player:Player):
	super.使用触发(player)
	player.吞饮粘浆=self

func 是否能够使用(player:Player)->bool:
	return player.吞饮粘浆==null

func get_desc(player:Player,otherJson:Dictionary={})->String:
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	otherJson.set("法术攻击值",3+合计加成.atk)
	otherJson.set("法术生命值",3+合计加成.hp)
	return super.get_desc(player,otherJson)

func 执行(player:Player):
	#在你的回合结束时，使你的龙获得+{0}攻击力。持续3回合。3在你的回合结束时，使你的龙获得+{0}/+{1}。持续3回合。
	var list=player.战场.获取所有节点()
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	for i:CardData in list:
		if i.card_data.是否属于种族(Enums.RaceEnum.DRAGON):
			var 属性=get_AttributeBonus()
			属性.atk=3+合计加成.atk
			属性.hp=0+合计加成.atk
			i.cardData.属性添加(self,player,属性)
