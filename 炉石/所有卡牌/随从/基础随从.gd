extends LuShiCard
class_name BaseMinionCard
## 种族
@export var race:Array[Enums.CardRace]=[Enums.CardRace.无]
@export var atk_hp:Vector2=Vector2(0,0)
@export var 永久属性:Array[AttributeBonus]=[]
# 开始回合就会清理
@export var 临时属性:Array[AttributeBonus]=[]
@export var is_gold:bool=false

func 获取属性倍率()->int:
	if is_gold:
		return 2
	return 1

func 添加加成属性(加成:AttributeBonus,是否永久:bool):
	print("%s获取属性加成%s，是否为永久:%s"%[名称,加成,是否永久])
	if 是否永久:
		永久属性.append(加成)
	else:
		临时属性.append(加成)

func 是否属于该种族(种族:Enums.CardRace)->bool:
	return race.has(种族)
