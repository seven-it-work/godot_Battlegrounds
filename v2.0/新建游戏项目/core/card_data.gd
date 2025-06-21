extends Control
class_name CardData

@onready var 使用时是否需要选择目标:TargetSelector=$"使用时是否需要选择目标"

@export var name_str:String
@export var 所在位置:Enums.CardPosition=Enums.CardPosition.NONE
@export var uuid:String=""
@export var version:String=""
@export var ls_card_id:String=""
@export var show_name_str:bool=true
# 等级
@export var lv:int=1
@export var show_lv:bool=true
## 攻击力
@export var atk:int=0;
@export var show_atk:bool=true
## 生命值
@export var hp:int=1
## 当前生命值（用于战斗计算，这个应该改名为受到的伤害）
@export var current_hp:int=0

@export var show_hp:bool=true
## 描述
@export var desc:String=""
@export var gold_desc:String=""
@export var cardType:Enums.CardTypeEnum=Enums.CardTypeEnum.MINION
## 是否为金色
@export var is_gold:bool=false
# 属性
@export var 嘲讽:bool=false
@export var 圣盾:bool=false
@export var 复生:bool=false
# 一次性毒
@export var 剧毒:bool=false
@export var 风怒:bool=false
@export var 潜行:bool=false

var 额外属性:Array[String]=["嘲讽","圣盾","复生","剧毒","风怒","潜行"]

# 种族
@export var race:Array[Enums.RaceEnum]=[Enums.RaceEnum.NONE]
# 限定出现种族（有这个种族才出现 none表示没有限定）
@export var 限定出现种族:Array[Enums.RaceEnum]=[Enums.RaceEnum.NONE]
# 特殊属性
@export var 超级风怒:bool=false
# 永久性性毒
@export var 烈毒:bool=false
@export var 是否为伙伴:bool=false
@export var 是否出现在酒馆:bool=true
@export var 磁力:bool=false

## 是否使用时是否需要选中目标
@export var need_select_target:bool=false

#@export var 亡语:Array[Dead]=[]
@export var 战吼:Array[Roar]=[]
#@export var 抉择:ToChoose

# 插画路径
@export var 插画路径:String=""
@export var 文件路径:String=""
@export var 文件名:String=""
# 永久区
#@export var 属性加成:Array[AttributeBonus]=[]
#@export var 临时属性加成:Array[AttributeBonus]=[]
# 出售金额
@export var sell_coins:int=1
# 购买需要金币
@export var buy_coins:int=3
@export var show_buy_coins:bool=false
# 是否为伙伴
@export var is_companion:bool=false
@export var 复仇:int=0
var 复仇计数器:int=0
# 其他自定义扩展属性
@export var other_data:Dictionary={}

@export var 冻结:bool=false
@export var 触发:bool=false

func _ready() -> void:
	print("ready")

func 是否属于种族(race:Enums.RaceEnum)->bool:
	return self.race.has(race)

func 是否为法术()->bool:
	return [Enums.CardTypeEnum.SPELL,Enums.CardTypeEnum.TAVERN].has(self.cardType)

func 获取抉择节点()->Choose:
	var list= get_children().filter(func(x): return x is Choose)
	if list.is_empty():
		return null;
	return list[0]

#region 战吼相关操作
func 获取战吼节点()->Roar:
	var list= get_children().filter(func(x): return x is Roar)
	if list.is_empty():
		return null;
	return list[0]

func 是否有战吼()->bool:
	return 获取战吼节点()!=null

#endregion


#region 触发相关
func 使用触发监听(player:Player,使用的卡片:DragControl):
	print(name_str,"使用触发监听")

func 使用触发(player:Player):
	print(name_str,"使用触发")
	pass

#endregion
