
extends BaseCard
func 触发器_玩家受伤(palyer:Player,num:int)->int:
	num=super.触发器_玩家受伤(palyer,num)
	num=0
	palyer.酒馆随从临时+=Vector2(1,1)*(2 if is_gold else 1)
	return num
