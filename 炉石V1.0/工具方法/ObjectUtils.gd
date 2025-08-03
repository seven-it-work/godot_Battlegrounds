@tool
extends Object
class_name ObjectUtils

## 判断是否为空
static func is_empty(v)->bool:
	if v==null:
		return true
	if v is Dictionary:
		return v.is_empty()
	if v is Array:
		return v.is_empty()
	if v is String:
		return v==""
	return false

## 合并
static func merge(o,t,is_over:bool=false):
	if o is Dictionary && t is Dictionary:
		return o.merged(t,is_over)
	if o is Array && t is Array:
		var r=[]
		r.append_array(o)
		r.append_array(t)
		return r
	printerr("只支持 Dictionary 和 Array")

	## 释放对象以及其属性对象
static func free_obj(obj):
	if obj==null: return
	if obj is Dictionary:
		for i in obj.values():
			free_obj(i)
	elif obj is Array:
		for i in obj:
			free_obj(i)
	elif obj is Node:
		for i in obj.get_property_list():
			if i.usage==4102:
				if obj[i.name]:
					free_obj(obj[i.name])
		obj.queue_free()
	elif obj is Object:
		for i in obj.get_property_list():
			if i.usage==4102:
				if obj[i.name]:
					free_obj(obj[i.name])
		obj.free()
	else:
		# 不释放
		pass
	pass


static func copy(obj:Object)->Object:
	return dict_2_inst(inst_2_dict(obj))


static func copyDic(dic:Dictionary)->Dictionary:
	var dic_new={}
	for key in dic:
		if dic[key] is Dictionary:
			dic_new[key]=dic[key]
		else:
			dic_new[key]=dict_2_inst(inst_2_dict(dic[key]))
	return dic_new


static func copyBean(soure:Dictionary,target:Object):
	for key in soure.keys():
		if target.has_method("set_"+key) or key in target:
			target.set(key,soure[key])

static func dict_2_inst(d:Dictionary):
	for i in d.keys():
		if d[i] is Dictionary:
			d[i]=dict_2_inst(d[i])
	if d.has("@path"):
		return dict_to_inst(d)
	else :
		return d;

static func inst_2_dict(obj:Object)->Dictionary:
	return dict_convert(inst_to_dict(obj).duplicate(true))

static func dict_convert(d:Dictionary)->Dictionary:
	for key in d.keys():
		if d[key] is Dictionary:
			d[key]=dict_convert(d[key])
		elif d[key] is Object:
			d[key]=dict_convert(inst_to_dict(d[key]))
	return d;


## 获取对象中所有@export修饰的属性及其值
static func get_exported_properties(obj: Object) -> Dictionary:
	var result = {}
	if not obj:
		return result
	
	var script = obj.get_script()
	if not script:
		return result
	
	# 获取脚本中定义的所有属性
	for property in script.get_script_property_list():
		var property_name: String = property["name"]
		# 检查是否是脚本变量且可读
		if (property["usage"] & PROPERTY_USAGE_SCRIPT_VARIABLE) and \
		   (property["usage"] & PROPERTY_USAGE_EDITOR):
			# 获取属性值
			var value = obj.get(property_name)
			result[property_name] = value
	
	return result
## 获取通用的to_string打印信息
static func get_to_string(obj:Object)->Dictionary:
	var dic=ObjectUtils.get_exported_properties(obj)
	dic.set("pathInfo", obj.get_path() if obj.is_inside_tree() else null)
	dic.set("objectId",obj.get_instance_id())
	dic.set("nameInfo",obj.name)
	return dic
