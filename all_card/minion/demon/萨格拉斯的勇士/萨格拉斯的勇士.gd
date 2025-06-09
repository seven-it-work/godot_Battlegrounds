
extends BaseCard

func 触发器_出售(player:Player):
	super.触发器_出售(player)
	player.酒馆随从加成-=Vector2(10,10)*(2 if is_gold else 1)
	pass
func 触发器_使用(player:Player,目标卡片:BaseCard):
	super.触发器_使用(player,目标卡片)
	player.酒馆随从加成+=Vector2(10,10)*(2 if is_gold else 1)
	pass

	
