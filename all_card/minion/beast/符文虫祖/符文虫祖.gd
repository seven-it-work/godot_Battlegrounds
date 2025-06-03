
extends BaseCard

func 触发器_复仇(palyer:Player):
	palyer.甲虫+=Vector2(2,2)*2 if is_gold else 1
	pass
