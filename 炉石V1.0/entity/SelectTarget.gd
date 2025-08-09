extends Node
class_name SelectTarget

var _原始卡片:CardEntity
var 目标卡片:CardEntity

func 获取选择的目标对象(list:Array):
	var 过滤list=list\
		.filter(func(item:CardEntity): return item.卡牌类型==Enums.CardType.随从)
	return 过滤list
	
func 是否有目标(list:Array)->bool:
	return ArrayUtils.is_not_empty(获取选择的目标对象(list))
