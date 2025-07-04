extends CardData
var 邻居=[]
func 触发器_死亡移除前(触发者:CardData):
	var index=get_index()
	var list=player.获取战场中的牌()
	邻居=ArrayUtils.get_neighboring_data(self,player.获取战场中的牌())
