
extends BaseCard

func 触发器_攻击后(player:Player,攻击目标:BaseCard):
	super.触发器_攻击后(player,攻击目标)
	if player.敌人战斗list.size()<=0:
		return
	var 相邻随从=ArrayUtils.get_neighboring_data(攻击目标,player.敌人战斗list)
	for i:BaseCard in 相邻随从:
		i.add_hp(self,atk_bonus(),player)
	pass
