
extends BaseCard
var 效果:Vector2=Vector2(1,1)

func 触发器_复仇(palyer:Player):
	palyer.minion_property_func(self,func(card:BaseCard):
		card.效果+=Vector2(1,1)*2 if is_gold else 1
	,true)
	pass
