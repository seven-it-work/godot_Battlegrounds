@tool
extends Object
class_name JsonUtils

static func obj2Json(obj,obj_map:Dictionary[int,Object]={}):
	if obj==null:
		return null
	if obj is Dictionary:
		var re={}
		for key in obj:
			re[key]=obj2Json(obj[key],obj_map)
		return re;
	if obj is Array:
		return obj.map(func(t): return obj2Json(t,obj_map))
	if obj is Object:
		if obj_map.has(obj.get_instance_id()):
			return "object映射_"+str(obj.get_instance_id())
		obj_map.set(obj.get_instance_id(),obj)
		var 属性列表=obj.get_property_list()\
			.filter(func(dic): return [4102].has(dic.usage))
		
		var file_path=obj.get_script().get_path()
		if StrUtils.is_not_blank(obj.scene_file_path):
			file_path=obj.scene_file_path
		var result={
			"file_path"=file_path,
			"object_id"=obj.get_instance_id(),
		}
		for i in 属性列表:
			result[i.name]=obj[i.name]
		return obj2Json(result,obj_map)
#● TYPE_NIL = 0
#变量为 null。
#● TYPE_BOOL = 1
#变量类型为 bool。
#● TYPE_INT = 2
#变量类型为 int。
#● TYPE_FLOAT = 3
#变量的类型为 float。
#● TYPE_STRING = 4
#变量类型为 String。
	if typeof(obj)>4:
		var dic=JSON.from_native(obj,true)
		return dic
	return obj

static func json2Obj(dic,obj_map:Dictionary[int,Object]={}):
	if dic==null:
		return null
	if dic is Dictionary:
		if dic.has("file_path"):
			var file_path=dic.get("file_path") as String
			if file_path.ends_with(".gd"):
				var obj=load(file_path).new()
				for key in dic.keys():
					if obj.has_method("set_"+key):
						var 数据=json2Obj(dic[key],obj_map)
						obj.set(key,数据)
					elif key in obj:
						var 数据=json2Obj(dic[key],obj_map)
						print(type_string(typeof(数据)))
						var data=obj.get(key)
						if data is Array:
							data.append_array(数据 as Array)
						else:
							obj.set(key,数据)
				
				var obj_id=dic.get("object_id") as int
				obj_map.set(obj_id,obj)
				return obj
			elif file_path.ends_with(".tscn"):
				var obj=load(file_path).instantiate()
				for key in dic.keys():
					if obj.has_method("set_"+key) or key in obj:
						obj.set(key,json2Obj(dic[key],obj_map))
				obj_map.set(dic.get("object_id") as int,obj)
				return obj
			else:
				print("内置脚本，展示不支持反序列化")
				return null
		elif dic.has("type"):
			return JSON.to_native(dic,true)
			#printerr("错误了，无法反序化 dic=",dic)
			#return null
		else:
			var re={}
			for key in dic:
				re[key]=json2Obj(dic[key],obj_map)
			return re
	if dic is Array:
		var array=dic.map(func(t): return json2Obj(t,obj_map)).filter(func(item): return item!=null)
		return array
	return dic
	
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
