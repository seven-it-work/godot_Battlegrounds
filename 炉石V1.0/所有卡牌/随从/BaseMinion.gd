extends CardEntity
class_name BaseMinion

## 种族
@export var race:Array[Enums.CardRace]=[Enums.CardRace.无]
## 限定类型
@export var 限定类型:Array[Enums.CardRace]=[]
## 基础攻击力、生命值
@export var atk_hp:Vector2=Vector2(0,0)
## 当前生命值（战斗开始时会进行重置）
@export var current_hp:int=0
@export var 永久属性:Array[AttributeBonus]=[]
# 开始回合就会清理
@export var 临时属性:Array[AttributeBonus]=[]
@export var is_gold:bool=false
@export var glod_描述:String=""
@export var 战吼:Array[Roar]=[]

func 是否能够使用()->bool:
	return true

func 获取描述(dic:Dictionary={})->String:
	var tempDic=ObjectUtils.get_exported_properties(self)
	tempDic.merged(dic,true)
	if is_gold:
		return glod_描述.format(tempDic)
	return 描述.format(tempDic)

func 获取倍率()->int:
	if is_gold:
		return 2
	return 1
