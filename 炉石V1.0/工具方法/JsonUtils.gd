@tool
extends Object
class_name JsonUtils

static func obj2Json(obj,obj_map:Dictionary[int,Object]):
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
			return obj2Json("object映射_"+str(obj.get_instance_id()),obj_map)
		else:
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
	var dic=JSON.from_native(obj,true)
	return dic

static func json2Obj(dic,obj_map:Dictionary[int,Object]):
	if dic==null:
		return null
	if dic is Dictionary:
		if dic.has("file_path"):
			var file_path=json2Obj(dic.get("file_path"),obj_map) as String
			var obj
			if file_path.ends_with(".gd"):
				obj=load(file_path).new()
			elif file_path.ends_with(".tscn"):
				obj=load(file_path).instantiate()
			else:
				#printerr("内置脚本，不支持反序列化。dic=",dic)
				return null
			var obj_id=json2Obj(dic.get("object_id"),obj_map) as int
			obj_map.set(obj_id,obj)
			for key in dic.keys():
				var value=dic[key]
				if obj.has_method("set_"+key):
					var 数据=json2Obj(value,obj_map)
					obj.set(key,数据)
				elif key in obj:
					var 数据=json2Obj(value,obj_map)
					var data=obj.get(key)
					if data is Array:
						data.clear()
						data.append_array(数据)
					else:
						obj[key]=数据
			return obj
		elif dic.has("type"):
			var re=JSON.to_native(dic,true)
			return re
		else:
			var re={}
			for key in dic:
				re[key]=json2Obj(dic[key],obj_map)
			return re
	if dic is Array:
		var array=dic.map(func(t): return json2Obj(t,obj_map)).filter(func(item): return item!=null)
		return array
	if dic is Object:
		return dic
	var obj=JSON.to_native(dic,true)
	if obj is String:
		if obj.begins_with("object映射_"):
			var id=obj.replace("object映射_","") as int
			if obj_map.has(id):
				return obj_map.get(id)
			else:
				printerr("没有对应对象dic=",dic,obj_map.keys())
				print_stack()
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
