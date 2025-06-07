
extends BaseCard
var 效果:Vector2=Vector2(1,1)

func 触发器_复仇(palyer:Player):
	效果+=Vector2(1,1)*(2 if is_gold else 1)
	pass
