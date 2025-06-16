extends BaseCard

func 触发器_使用(player:Player,目标卡片:BaseCard):
	super.触发器_使用(player,目标卡片)
	pass

func 过滤可以选中数据(card:BaseCard)->bool:
	return false
