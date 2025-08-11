extends Node
class_name Player

@export var 酒馆等级:int=1
@export var 酒馆:Array=[]
@export var 战场:Array=[]
@export var 手牌:Array=[]
@export var 生命值:int=0
@export var 当前金币:int=0
@export var 开始回合调用方法:Array=[]
## 影响元素属性加成
@export var 元素加强加成:Vector2i=Vector2i(0,0)
@export var 元素属性加成:Vector2i=Vector2i(0,0)
@export var 鲜血宝石加成:Vector2i=Vector2i(1,1)
@export var 甲虫加成:Vector2i=Vector2i(2,2)

@export var 下次购买法术金币减少数量:int=0

#region 战斗相关属性
## Array[CardEntity]
var 战斗中的随从:Array=[]
## key=战场上的随从 value=战斗中的随从
var 战场_战斗中的对象映射map:Dictionary={}
var 当前攻击的随从索引:int=0
var fightUI:FightUI

## Array[CardEntity]
func 获取战场上的牌()->Array:
	if 是否在战斗中():
		return 战斗中的随从
	return 战场

func 重置攻击随从():
	for i in 战斗中的随从:
		i.是否攻击过=false
	当前攻击的随从索引=0
	
func 战斗初始化(fightUI:FightUI):
	self.fightUI=fightUI
	# 初始化战斗中的随从
	for i in 战场:
		var 复制=i.duplicate() as BaseMinion
		复制.卡片所在位置=Enums.CardPosition.战场
		复制.current_hp=复制.获取带加成属性().y
		战场_战斗中的对象映射map.set(复制,i)
		战斗中的随从.append(复制)
	重置攻击随从()
	pass
	
func 是否在战斗中()->bool:
	return fightUI!=null
#endregion

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
signal 亡语触发信号(亡语卡牌:CardEntity)
signal 出售随从信号(出售卡牌:CardEntity)
signal 随从属性加成信号(加成随从:CardEntity,加成数据:AttributeBonus)
signal 开始回合信号()
signal 回合结束信号()

func 购买卡片(card:CardEntity):
	删除卡牌(card,Enums.CardPosition.酒馆,false)
	# 金币扣除
	var 花费=card.获取花费()
	if card is TavernSpell:
		下次购买法术金币减少数量=0
	当前金币-=花费
	pass

func 结束回合():
	回合结束信号.emit()
	print("结束回合了")
	pass


func 手牌是否满了()->bool:
	return 手牌.size()>=10;
## Array[CardEntity]
func 获取酒馆And战场的牌()->Array:
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
	#print("添加卡牌")
	d.player=self
	d.卡片所在位置=cardPosition
	if 是否触发信号:
		添加卡片信号.emit(d,cardPosition,index)
	if cardPosition==Enums.CardPosition.酒馆:
		元素工具类.元素属性加成(d,self)
		index=adjust_index(index,酒馆)
		酒馆.insert(index,d)
		return
	if cardPosition==Enums.CardPosition.手牌:
		手牌.insert(adjust_index(index,手牌),d)
		return
	if cardPosition==Enums.CardPosition.战场:
		if 是否在战斗中():
			d.current_hp=d.获取带加成属性().y
			战斗中的随从.insert(index,d)
			return
		战场.insert(adjust_index(index,战场),d)
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
		if 是否在战斗中():
			战斗中的随从.erase(d)
		else:
			战场.erase(d)
		return
	pass

func adjust_index(index: int, array: Array) -> int:
	if array.size() == 0:
		return -1+1  # 数组为空时返回 -1 或其他处理方式
	var size = array.size()
	# 处理负数索引
	if index < 0:
		# 负数索引从数组末尾开始计算
		index = (index % size + size) % size
	else:
		# 正数索引从数组开头开始计算
		index = index % size
	return index+1


func 生命值扣除(num:int):
	生命值-=1;
	pass

func 出售随从(card:CardEntity):
	删除卡牌(card,Enums.CardPosition.战场,false)
	出售随从信号.emit(card)
	if card is BaseMinion:
		# 金币获取
		当前金币+=card.出售金币

func 获取卡片索引(card:CardEntity)->int:
	if card.卡片所在位置==Enums.CardPosition.酒馆:
		return 酒馆.find(card)
	if card.卡片所在位置==Enums.CardPosition.战场:
		if 是否在战斗中():
			var index=战斗中的随从.find(card)
			return index
		return 战场.find(card)
	if card.卡片所在位置==Enums.CardPosition.手牌:
		return 手牌.find(card)
	return -1
