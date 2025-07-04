extends CardData

# todo 这里有个疑问：
# A亡语-触发1次->召唤3个随从->触发第二个-再召唤1个->1+3+1=5个了
# A亡语-触发1次->召唤3个随从->只能召唤2个了
# 第二种：
# A亡语-触发1次->召唤3个随从->触发第二次->1+3+3
# 其他亡语再触发 就不能召唤了
func 触发器_战斗开始时():
	var list=[]
	var count=0;
	for j:CardData in player.获取战场中的牌():
		if j.是否存在亡语():
			count+=1;
			for i in 获取是否为金色的倍率():
				j.触发器_亡语(self)
		if count==2:
			break
	pass
