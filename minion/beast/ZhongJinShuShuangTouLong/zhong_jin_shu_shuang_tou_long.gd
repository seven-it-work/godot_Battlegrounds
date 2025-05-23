extends BaseCard

var neighboring:Array[BaseCard]=[]
# 随从死亡时
func dead(player:Player):
	neighboring=player.get_neighboring_minion(self)
	super.dead(player)
	pass
