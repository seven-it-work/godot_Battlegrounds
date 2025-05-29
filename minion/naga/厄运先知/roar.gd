extends Roar

func 战吼(触发者:BaseCard,player:Player,目标对象:BaseCard):
	player.下一次酒馆法术花费减少=2 if 触发者.is_gold else 1
	pass
