extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	# Assuming the killer is stored in the minion's _killer variable
	var killer = 触发卡._killer
	if killer:
		# Destroy the killer
		await killer.生命扣除(触发卡, 999) # Destroy the killer
		print("莽神火车王触发亡语：消灭击杀者")
