extends Node
class_name WeightedProbabilityUtils

static func WeightedSelect(weightDic:Dictionary[String,float])->String:
	var total=ArrayUtils.sum(weightDic.values())
	var randomV=randf_range(0,total)
	var current=0
	for i in weightDic:
		if randomV<=weightDic.get(i)+current:
			return i;
		current+=weightDic.get(i)
	printerr("错误了")
	return ""
