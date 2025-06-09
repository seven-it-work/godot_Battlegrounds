
extends BaseCard

func 触发器_玩家受伤(player:Player,num:int)->int:
	num=super.触发器_玩家受伤(player,num)
	add_atk(self,2*(2 if is_gold else 1),player)
	add_hp(self,2*(2 if is_gold else 1),player)
	return num
	
