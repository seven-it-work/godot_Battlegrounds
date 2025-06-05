@tool
extends Node
class_name ArrayUtils

static  func group_by(list:Array,key_func:Callable)->Dictionary:
	var result={}
	for i in list:
		var key = key_func.call(i)
		if result.has(key):
			result[key].append(i)
		else:
			result[key]=[i]
	return result

static func get_neighboring_data(data ,array:Array)->Array:
	if array.size()<=1:
		print("数量小于2，不可能有相邻的")
		return []
	var index=-1;
	for i in array.size():
		var temp=array.get(i)
		if temp==data:
			index=i;
			break
	if index==-1:
		print("没有找到对应数据")
		return []
	if index==0:
		return [array.get(index+1)]
	if index==array.size()-1:
		return [array.get(index-1)]
	return [array.get(index-1), array.get(index+1)]
