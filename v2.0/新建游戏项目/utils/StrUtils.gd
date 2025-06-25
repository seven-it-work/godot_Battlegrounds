extends Node
class_name StrUtils

## 对 s字符串中的${}这种格式进行提取，然后将json中的path放入${}中
# 例子：s=你好！${a.b.c} json={a:{b:{c:"世界"}} 输出 你好！世界 。a.b.c通过JsonUtils.get_nested_value来获取
# var value=JsonUtils.get_nested_value(json,"a.b.c");  value的结果为世界（这个方法我实现了，你直接调用即可）
static func 自定义format(s:String,json:Dictionary)->String:
	return s;

static func is_blank(s:String)->bool:
	var temp=trim(s);
	if temp==null:
		return true;
	if temp=="":
		return true;
	return false;

static func is_not_blank(s:String)->bool:
	return !is_blank(s);
	
static func trim(s:String):
	if s==null:
		return "";
	return s.trim_prefix(" ").trim_suffix(" ")
