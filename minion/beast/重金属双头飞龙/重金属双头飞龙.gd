extends BaseCard

var neighboring:Array[BaseCard]=[]

func 触发器_亡语(attaker:BaseCard,player:Player):
	neighboring=player.get_neighboring_minion(self)
	super.触发器_亡语(attaker,player)
	pass
