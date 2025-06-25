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


## 从数组中random pick对象
# arr:数组
# size:pick个数
# is_duplicate:否运行pick对象重复
static  func random_pick(arr:Array,size:int=1,is_duplicate:bool=true)->Array:
	var re=[]
	if size <= 0:
		return re
	if is_duplicate:
		for i in size:
			re.append(arr.pick_random())
	else:
		if size >= arr.size():
			return arr.duplicate()
		var shuffled = arr.duplicate()
		shuffled.shuffle()
		return shuffled.slice(0, size)
	return []

# 判断两个数组是否相等
static func is_equal(arr1:Array,arr2:Array)->bool:
	if arr1.size()!=arr2.size():
		return false
	for i in arr1:
		if i not in arr2:
			return false
	return true
