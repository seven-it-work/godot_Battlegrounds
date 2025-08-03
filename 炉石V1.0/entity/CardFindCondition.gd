extends Node
class_name CardFindCondition

static func build(key:String,value,判断:Enums.ConditionEnum,且或:bool=true)->CardFindCondition:
	var re=CardFindCondition.new()
	re.key=key
	re.value=value
	re.判断=判断
	re.且或=且或
	return re;

# card的属性
var key:String=""
var value
var 判断:Enums.ConditionEnum
# 且：true  与多个其他条件组合
var 且或:bool=true
