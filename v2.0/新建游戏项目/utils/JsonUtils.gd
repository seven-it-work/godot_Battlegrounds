class_name JsonUtils

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

## 自定义json转obj方法
static func json_2_obj(json):
	if json == null:
		return null
	if json is Array:
		return json.map(func(t): return json_2_obj(t))
	if json is Dictionary:
		if json.has("filename") && json["filename"]:
			var obj
			if json["filename"].begins_with("uid://"):
				obj=dict_to_inst({"@path":json["filename"]})
			elif json["filename"].ends_with(".gd"):
				obj=dict_to_inst({"@path":json["filename"]})
			else:
				obj=load(json["filename"]).instantiate()
			if obj.has_method("load_json"):
				## 自定义解析json方法
				obj.call("load_json",json)
				return obj;
			for key in json:
				if key!="filename":
					var d=json_2_obj(json.get(key))
					obj[key]=d
			return obj;
		else:
			var re={}
			for key in json:
				re[key]=json_2_obj(json[key])
			return re
	# 如果是字符串，则返回字符串
	if json is String:
		return json
	if json is int:
		return json
	if json is float:
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
	if obj is Object :
		if obj.has_method("save_json"):
			## 自定义解析json方法
			return obj.call("save_json")
		# 这里去读取obj的get_property_list
		var re={}
		var filename=null
		if obj.get_script():
			filename=obj.get_script().resource_path
		var property_list=obj.get_property_list()
		for i in property_list:
			if i.hint_string.begins_with("res://"):
				if filename:
					re["filename"]=filename
				else:
					re["filename"]=i.hint_string
			elif i.usage==69638:
				# enum
				re[i.name]=obj[i.name]
			elif i.usage==4102:
				if i.hint==34:
					# obj
					re[i.name]=obj_2_json(obj[i.name])
				elif i.type==28:
					# array
					re[i.name]=obj_2_json(obj[i.name])
				elif i.type==27:
					# dic
					re[i.name]=obj_2_json(obj[i.name])
				else:
					re[i.name]=obj[i.name]
		return re
	# 如果是字符串，则返回字符串
	if obj is String:
		return obj
	if obj is int:
		return obj
	if obj is float:
		return obj
	print("不知道类型了",obj)
	return obj
