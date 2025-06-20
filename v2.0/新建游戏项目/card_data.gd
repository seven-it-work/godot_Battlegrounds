extends Control
class_name CardData

@onready var 使用时是否需要选择目标:TargetSelector=$"使用时是否需要选择目标"

@export var name_str:String
@export var 所在位置:Enums.CardPosition=Enums.CardPosition.NONE
@export var cardType:Array[Enums.RaceEnum]=[Enums.RaceEnum.NONE]

func _ready() -> void:
	print("ready")

func 是否属于种族(cardType:Enums.RaceEnum)->bool:
	return self.cardType.has(cardType)

#region 战吼相关操作
func 获取战吼节点()->Roar:
	var list= get_children().filter(func(x): return x is Roar)
	if list.is_empty():
		return null;
	return list[0]

func 是否有战吼()->bool:
	return 获取战吼节点()!=null

func 战吼时是否需要选择目标()->bool:
	if 是否有战吼():
		var roar=获取战吼节点()
		if roar:
			return roar.targetSelector.是否需要选择目标
	return false
#endregion


#region 触发相关
func 使用触发监听(player:Player,使用的卡片:DragControl):
	print(name_str,"使用触发监听")

func 使用触发(player:Player):
	print(name_str,"使用触发")
	pass

#endregion
