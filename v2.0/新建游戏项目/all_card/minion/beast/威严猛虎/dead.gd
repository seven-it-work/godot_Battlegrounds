extends Dead

var baseAtk=5
var baseHp=5

func 亡语(攻击者:CardData,player:Player):
	var list=player.获取战场中的牌()
	var 最右边的野兽:CardData
	var index=list.size()-1
	while true:
		if index<0:
			break
		var card=list.get(index) as CardData
		index-=1
		if card.是否属于种族(Enums.RaceEnum.BEAST):
			最右边的野兽=card
			break
	if 最右边的野兽==null:
		print("没有野兽了")
		return
	var 属性=亡语者.get_AttributeBonus()
	属性.atk+=baseAtk*(2 if 亡语者.is_gold else 1)
	属性.hp+=baseHp*(2 if 亡语者.is_gold else 1)
	最右边的野兽.属性添加(亡语者,属性,true)
