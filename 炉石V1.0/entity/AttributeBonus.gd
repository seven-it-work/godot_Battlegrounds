extends Node
class_name AttributeBonus

@export var 加成卡片名称:String=""
@export var atk_hp:Vector2=Vector2(0,0)
@export var 加成描述:String=""

static func build(
	加成卡片名称:String,
	atk_hp:Vector2,
	加成描述:String,
)->AttributeBonus:
	var result=AttributeBonus.new()
	result.加成卡片名称=加成卡片名称
	result.atk_hp=atk_hp
	result.加成描述=加成描述
	return result


func _to_string() -> String:
	return JSON.stringify(ObjectUtils.get_to_string(self))
