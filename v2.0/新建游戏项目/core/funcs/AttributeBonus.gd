class_name AttributeBonus extends Node

@export var key:String=""
@export var atk:int=0;
@export var hp:int=0;
@export var name_str:String=""

static func create(key:String,atk:int,hp:int,name_str:String)->AttributeBonus:
	var result=AttributeBonus.new()
	result.key=key;
	result.atk=atk;
	result.hp=hp;
	result.name_str=name_str;
	return result

static func 计算总和(list:Array[AttributeBonus])->AttributeBonus:
	var result=AttributeBonus.new()
	for item in list:
		result.atk+=item.atk
		result.hp+=item.hp
	return result
