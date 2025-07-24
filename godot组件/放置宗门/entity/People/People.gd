extends Node
class_name People

@export var hp:float=0
@export var hp_max:float=0
@export var fight_power:float=0
@export var lv:int=0
@export var exp:float=0
@export var exp_max:float=0
@export var efficiency:float=0
@export var cool_time:float=0


func travel():
	var 权重:Dictionary[String,float]={
		"灵石":50,
		"灵木":30,
		"灵草":20,
		"灵脉":10,# 可以被占领，占领后可以派遣弟子生产灵石
		"妖兽":20,# 损失生命值获得一定量的灵气值
		"其他宗门":0.5,# 遇到了，可以进攻 抢夺资源
		"灵气":20,
		"秘境":0.5,# 提升属性（执行效率、执行速度等）
	}
	var map={}
	for i in 1000:
		var key=WeightedProbabilityUtils.WeightedSelect(权重)
		var value=map.get_or_add(key,0)
		map.set(key,value+1)
	print(map)
	pass
