extends BaseCard

func 触发器_使用(player:Player,目标卡片:BaseCard):
	super.触发器_使用(player,目标卡片)
	目标卡片.add_atk(self,1,player)
	目标卡片.add_hp(self,1,player)
	pass
