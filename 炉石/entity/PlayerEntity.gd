extends Node
class_name PlayerEntity

@export var 酒馆:Array[CardEntity]=[]
@export var 战场:Array[CardEntity]=[]
@export var 手牌:Array[CardEntity]=[]

## 元素加成(攻击力/生命值)
@export var 元素加成:Vector2=Vector2(0,0)

signal 添加卡牌信号(d:CardEntity,cardPosition:Enums.CardPosition,index:int)
signal 删除卡牌信号(d:CardEntity,cardPosition:Enums.CardPosition)

func 获取酒馆And战场的牌()->Array[CardEntity]:
	var result:Array[CardEntity]=[]
	for i in 酒馆:
		if i is CardEntity:
			result.append(i as CardEntity)
	for i in 战场:
		if i is CardEntity:
			result.append(i as CardEntity)
	return result

func 删除卡牌(d:CardEntity,cardPosition:Enums.CardPosition):
	if cardPosition==Enums.CardPosition.酒馆:
		酒馆.erase(d)
		删除卡牌信号.emit(d,cardPosition)
		return
	if cardPosition==Enums.CardPosition.手牌:
		手牌.erase(d)
		删除卡牌信号.emit(d,cardPosition)
		return
	if cardPosition==Enums.CardPosition.战场:
		战场.erase(d)
		删除卡牌信号.emit(d,cardPosition)
		return
	printerr("错误删除卡牌卡片",d,cardPosition)
	print_stack()
	pass

func 添加卡片(d:CardEntity,cardPosition:Enums.CardPosition,index:int):
	d.信号绑定方法()
	添加卡牌信号.emit(d,cardPosition,index)
	if cardPosition==Enums.CardPosition.酒馆:
		酒馆.insert(_调整索引(index,酒馆),d)
		return
	if cardPosition==Enums.CardPosition.手牌:
		手牌.append(d)
		return
	if cardPosition==Enums.CardPosition.战场:
		战场.append(d)
		return
	printerr("错误添加卡片",d,cardPosition)
	print_stack()

func _调整索引(i:int,array:Array)->int:
		i=i%array.size()
		if i<0:
			return i+array.size()
		return i
