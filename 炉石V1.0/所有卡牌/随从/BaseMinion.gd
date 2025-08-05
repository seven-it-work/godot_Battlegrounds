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
@export var 战吼:Array[Roar]=[]
@export var 出售金币:int=1;

@export var 嘲讽:bool=false
## 特供给一个法术
@export var 移除嘲讽:bool=false


func 是否能够使用()->bool:
	return true

func 获取描述(dic:Dictionary={})->String:
	var tempDic=ObjectUtils.get_exported_properties(self)
	tempDic.merged(dic,true)
	if is_gold:
		return glod_描述.format(tempDic)
	return 描述.format(tempDic)


func 获取带加成属性()->Vector2:
	var result=Vector2(atk_hp)
	for i in 永久属性:
		result+=i.atk_hp
	for i in 临时属性:
		result+=i.atk_hp
	return result

func 属性加成(data:AttributeBonus,是否永久:bool):
	if 是否永久:
		永久属性.append(data)
	else:
		临时属性.append(data)
