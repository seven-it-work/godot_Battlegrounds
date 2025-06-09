
extends BaseCard
func 触发器_玩家受伤(palyer:Player,num:int)->int:
	num=super.触发器_玩家受伤(palyer,num)
	num=0
	add_hp(self,2*(2 if is_gold else 1),palyer)
	return num
