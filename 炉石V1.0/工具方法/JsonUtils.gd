@tool
extends Object
class_name JsonUtils

## 自定义json创建实体方法
static func json_2_obj(json):
	if json == null:
		return null
	if json is Array:
		return json.map(func(t): return json_2_obj(t))
	if json is Dictionary:
		if json.has("filename") && json["filename"]:
			var obj
			if json["filename"].ends_with(".gd"):
				obj=dict_to_inst({"@path":json["filename"]})
			else:
				obj=load(json["filename"]).instantiate()
			if obj.has_method("load_json"):
				obj.call("load_json",json)
			return obj;
		else:
			var re={}
			for key in json:
				re[key]=json_2_obj(json[key])
			return re
	# 如果是字符串，则返回字符串
	if json is String:
		return json
	print("不知道类型了",json)
	return json

## 自定义json转换方法
static func obj_2_json(obj):
	if obj == null:
		return null
	if obj is Dictionary:
		var re={}
		for key in obj:
			re[key]=obj_2_json(obj[key])
		return re;
	if obj is Array:
		return obj.map(func(t): return obj_2_json(t))

	if obj is Object:
		if obj.has_method("save_json"):
			return obj.call("save_json")
		else:
			return obj_2_json(ObjectUtils.get_exported_properties(obj))
	# 如果是字符串，则返回字符串
	if obj is String:
		return obj
	print("不知道类型了",obj)
	return obj

## 从json中获取path的值 path用. 来表示子
static func get_nested_value(data:Dictionary,key_path:String):
	var keys=key_path.split(".")
	var current=data
	for key in keys:
		if current is Dictionary && key in current:
			current=current[key]
		else:
			return null
	return current;
