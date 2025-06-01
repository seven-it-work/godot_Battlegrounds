extends Roar

func 战吼(触发者:BaseCard,player:Player,目标对象:BaseCard):
	var add=Vector2(2,2) if 触发者.is_gold else Vector2(1,1)+player.元素加成
	player.酒馆元素加成+=add
	pass
