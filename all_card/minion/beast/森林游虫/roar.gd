extends Roar
func 战吼(触发者:BaseCard,player:Player,目标对象:BaseCard):
	player.甲虫+=Vector2(1,1)*2 if 触发者.is_gold else 1
	pass
