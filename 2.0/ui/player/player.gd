extends Node2D
class_name Player

@onready var 酒馆:=$"酒馆"
@onready var 战场:=$"战场"
@onready var 手牌:=$"手牌"

## 回合开始时回调的方法
@export var 回合开始时回调的方法:Array[Callable]=[]

#region 加成记录
# 暴吼兽王 就是本局召唤过的野兽次数
var 暴吼兽王加成:int=0;
# 野兽额外加成（atk,hp）（哼鸣蜂鸟专属）
var 野兽额外加成:Vector2=Vector2(0,0)
#endregion

var 最大战场随从数量:int=7

func _process(delta: float) -> void:
	$"其他信息/当前金币".text="当前金币:%s"%酒馆.当前金币
	pass

#region 酒馆相关方法
func 酒馆升级():
	pass
func 冻结随从():
	pass
func 酒馆刷新():
	酒馆.刷新()
	pass
func 获取酒馆随从():
	pass
func 出售随从(card:DragCard):
	#card.baseCard
	print("出售随从特性")
	pass
#endregion
func 使用卡牌(card:DragCard,目标卡牌:DragCard=null):
	# 条件判断
	var target=null
	if 目标卡牌:
		target=目标卡牌.baseCard
	var baseCard=card.baseCard
	if baseCard.cardType==Enum.CardTypeEnum.MINION:
		if 是否不能放置随从(card.baseCard):
			print("放不下了")
			return
		# 战吼触发
		baseCard.触发器_战吼(self,target)
	card.baseCard.触发器_使用(self,target)
	for i in 获取战场随从():
		i.baseCard.触发器_使用其他卡牌(card.baseCard,self,target)
	print("卡牌使用特效")
	pass
	
func 获取战场随从()->Array[DragCard]:
	return []

func 获取手牌():
	pass

func 召唤随从到战场(card:BaseCard,index:int):
	if 是否不能放置随从(card):
		return
	if card.race.has(BaseCard.RaceEnum.BEAST):
		暴吼兽王加成+=1
		if 野兽额外加成.x>0:
			card.属性加成.append(AttributeBonus.create("哼鸣蜂鸟专属",野兽额外加成.x,0,"哼鸣蜂鸟专属"))
	var cardUi=preload("uid://dthisa5oinhjm").instantiate()
	cardUi.baseCard=card
	if 是否在战斗中():
		# todo 战斗中的处理
		pass
	else:
		战场.添加卡片(cardUi,index)
	card.触发器_召唤(self)
	for i in 获取战场随从():
		if i.uuid!=card.uuid:
			i.触发器_召唤他人(card,self)
	pass
func 添加卡牌到手牌中(card:BaseCard):
	var cardUi=preload("uid://dthisa5oinhjm").instantiate()
	cardUi.baseCard=card
	手牌.添加卡片(cardUi)
	pass

#region 一些判断
func 是否在战斗中()->bool:
	return false
func 是否不能放置随从(baseCard:BaseCard,index:int=-1)->bool:
	if 获取战场随从().size()>=最大战场随从数量:
		print("放不下了")
		return true
	return false
#endregion
