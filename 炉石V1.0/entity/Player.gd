extends Node
class_name Player

@export var 酒馆:Array[CardEntity]=[]
@export var 战场:Array[CardEntity]=[]
@export var 手牌:Array[CardEntity]=[]


signal 添加卡片信号(
	d:CardEntity,
	cardPosition:Enums.CardPosition,
	index:int,
)

signal 删除卡片信号(
	d:CardEntity,
	cardPosition:Enums.CardPosition,
)

signal 使用卡牌信号(使用卡牌:CardEntity)
signal 战吼触发信号(战吼卡牌:CardEntity)

func 获取酒馆And战场的牌()->Array[CardEntity]:
	var result:Array[CardEntity]=[]
	for i in 酒馆:
		if i is CardEntity:
			result.append(i as CardEntity)
	for i in 战场:
		if i is CardEntity:
			result.append(i as CardEntity)
	return result

## 所有的添加卡牌入口
func 添加卡片(
	d:CardEntity,
	cardPosition:Enums.CardPosition,
	index:int,
	是否触发信号:bool
):
	print("添加卡牌")
	d.player=self
	if 是否触发信号:
		添加卡片信号.emit(d,cardPosition,index)
	#d.信号绑定方法()
	if cardPosition==Enums.CardPosition.酒馆:
		酒馆.insert(_调整索引(index,酒馆),d)
		return
	if cardPosition==Enums.CardPosition.手牌:
		手牌.insert(_调整索引(index,手牌),d)
		return
	if cardPosition==Enums.CardPosition.战场:
		战场.insert(_调整索引(index,战场),d)
		return
	printerr("错误添加卡片",d,cardPosition)
	print_stack()

## 所有的添加卡牌入口
func 删除卡牌(
	d:CardEntity,
	cardPosition:Enums.CardPosition,
	是否触发信号:bool):
	if 是否触发信号:
		删除卡片信号.emit(d,cardPosition)
	if cardPosition==Enums.CardPosition.酒馆:
		酒馆.erase(d)
		return
	if cardPosition==Enums.CardPosition.手牌:
		手牌.erase(d)
		return
	if cardPosition==Enums.CardPosition.战场:
		战场.erase(d)
		return
	pass

func _调整索引(i:int,array:Array)->int:
	if array.size()<=0:
		return 0;
	while i<0:
		i+=array.size()
	return i%array.size()
