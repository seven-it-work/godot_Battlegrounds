extends CardData

func get_desc(otherJson:Dictionary={})->String:
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	otherJson.set("法术攻击值",3+合计加成.atk)
	otherJson.set("法术生命值",3+合计加成.hp)
	return super.get_desc(player,otherJson)
	
func 使用触发():
	super.使用触发(player)
	var 属性=self.get_AttributeBonus()
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	属性.atk=3+合计加成.atk
	属性.hp=3+合计加成.hp
	player.元素酒馆加成.append(属性)
	pass
