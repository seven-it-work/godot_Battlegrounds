@tool
extends Node
class_name StrUtils

static func is_blank(str:String)->bool:
	if str==null:
		return true;
	return trim(str)==""
	
static func trim(str:String)->String:
	if str==null:
		return str;
	return str.trim_prefix(" ").trim_suffix(" ")
