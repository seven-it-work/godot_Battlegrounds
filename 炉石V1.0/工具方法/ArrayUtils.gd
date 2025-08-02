@tool
extends Object
class_name ArrayUtils

## 根据key_func进行分类为map
static  func group_by(list:Array,key_func:Callable)->Dictionary:
	var result={}
	for i in list:
		var key = key_func.call(i)
		if result.has(key):
			result[key].append(i)
		else:
			result[key]=[i]
	return result

## 获取data相邻的元素
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

#----------------------- 判断相关 -----------------------
## 判断数组是否为空
static func is_empty(arr: Array) -> bool:
	return arr == null or arr.is_empty()

## 判断数组是否非空
static func is_not_empty(arr: Array) -> bool:
	return not is_empty(arr)

## 判断两个数组是否长度相同
static func is_same_length(a: Array, b: Array) -> bool:
	if a == null or b == null:
		return false
	return a.size() == b.size()

#----------------------- 转换相关 -----------------------
## 将数组转换为字符串（带分隔符）
static func convert_string(arr: Array, delimiter: String = ", ") -> String:
	if is_empty(arr):
		return "[]"
	return "[" + delimiter.join(arr.map(func(item): return str(item))) + "]"

## 将数组转换为字典（需偶数长度）
static func to_dict(arr: Array) -> Dictionary:
	if is_empty(arr) or arr.size() % 2 != 0:
		return {}
	
	var result = {}
	for i in range(0, arr.size(), 2):
		result[arr[i]] = arr[i+1]
	return result

#----------------------- 操作相关 -----------------------
## 合并多个数组
static func merge(arrays: Array) -> Array:
	var result = []
	for arr in arrays:
		if arr is Array:
			result.append_array(arr)
	return result

## 去重（保持顺序）
static func distinct(arr: Array) -> Array:
	if is_empty(arr):
		return []
	
	var seen = {}
	var result = []
	for item in arr:
		if not seen.has(item):
			seen[item] = true
			result.append(item)
	return result

## 反转数组（非原地）
static func reverse(arr: Array) -> Array:
	if is_empty(arr):
		return []
	var temp=arr.duplicate()
	temp.reverse()
	return temp

## 获取数组切片（支持负数索引）
static func subarray(arr: Array, start: int, end: int = -1) -> Array:
	if is_empty(arr):
		return []
	
	var size = arr.size()
	var actual_start = clampi(start if start >=0 else size + start, 0, size)
	var actual_end = clampi(end if end >=0 else size + end, 0, size)
	
	if actual_start >= actual_end:
		return []
	
	return arr.slice(actual_start, actual_end)

#----------------------- 查找相关 -----------------------
## 查找元素首次出现位置
static func index_of(arr: Array, item) -> int:
	if is_empty(arr):
		return -1
	return arr.find(item)

## 查找元素最后出现位置
static func last_index_of(arr: Array, item) -> int:
	if is_empty(arr):
		return -1
	
	for i in range(arr.size()-1, -1, -1):
		if arr[i] == item:
			return i
	return -1

## 检查是否包含元素
static func contains(arr: Array, item) -> bool:
	return arr.has(item)

## 检查是否包含所有指定元素
static func contains_all(arr: Array, items: Array) -> bool:
	if is_empty(items):
		return true
	for item in items:
		if not arr.has(item):
			return false
	return true

#----------------------- 过滤相关 -----------------------
## 过滤数组（使用回调函数）
static func filter(arr: Array, callback: Callable) -> Array:
	var result = []
	for item in arr:
		if callback.call(item):
			result.append(item)
	return result

## 排除null/空值
static func clean(arr: Array) -> Array:
	return filter(arr, func(item): return item != null)

#----------------------- 随机相关 -----------------------
## 获取随机元素
static func random_item(arr: Array):
	if is_empty(arr):
		return null
	return arr[randi() % arr.size()]

## 打乱数组（Fisher-Yates算法）
static func shuffle(arr: Array) -> Array:
	if is_empty(arr):
		return []
	
	var result = arr.duplicate()
	for i in range(result.size()-1, 0, -1):
		var j = randi() % (i + 1)
		var temp = result[i]
		result[i] = result[j]
		result[j] = temp
	return result

#----------------------- 数学相关 -----------------------
## 计算数组元素总和（数值类型）
static func sum(arr: Array) -> float:
	var total = 0.0
	for item in arr:
		if item is int or item is float:
			total += item
	return total

## 获取最大值（数值类型）
static func max(arr: Array):
	if is_empty(arr):
		return null
	var max_val = arr[0]
	for item in arr:
		if item > max_val:
			max_val = item
	return max_val

## 获取最小值（数值类型）
static func min(arr: Array):
	if is_empty(arr):
		return null
	
	var min_val = arr[0]
	for item in arr:
		if item < min_val:
			min_val = item
	return min_val
