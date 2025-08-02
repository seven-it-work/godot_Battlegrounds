extends Node
class_name CardEntity

@export var 卡牌类型:Enums.CardType=Enums.CardType.随从
@export var 卡片所在位置:Enums.CardPosition=Enums.CardPosition.无
#@export var 抉择:Choose
#@export var 选择目标对象:SelectTarget
@export var lushi_id:int=0
@export var str_id:String=""
@export var 名称:String=""
@export var 描述:String=""
@export var 等级:int=0
@export var 花费:int=0

#region 辅助的一下对象，不能持久化
#endregion
