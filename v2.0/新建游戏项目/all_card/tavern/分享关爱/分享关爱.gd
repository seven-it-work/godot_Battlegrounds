extends CardData
func 使用触发(player:Player):
	super.使用触发(player)
	player.分享关爱=true
	pass

func 是否能够使用(player:Player)->bool:
	return !player.分享关爱
