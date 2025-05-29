extends Node
class_name Player

var 最大手牌数量:int=10
var 最大战场随从数量:int=7
## 血量
@export var hp:int=30;
## 护甲
@export var armor:int=0; 
@export var 手牌:Array[BaseCard]=[]
# 战斗中
@export var 战斗中的牌:Array[BaseCard]=[]
# 酒馆回合（非战斗中）
@export var 战场中的牌:Array[BaseCard]=[]
## 回合开始时回调的方法
var 回合开始时回调的方法:Array[Callable]=[]

# 野兽额外攻击力（哼鸣蜂鸟专属）
var beat_attack:int=0
# 甲虫加成(hp,atk)
var 甲虫:Vector2=Vector2(2,2)
# 元素加成(hp,atk)
var 元素加成:Vector2=Vector2(0,0)
# 酒馆元素加成
var 酒馆元素加成:Vector2=Vector2(0,0)
# 下一次酒馆法术花费减少
var 下一次酒馆法术花费减少:int=0

var 当前选中的随从:BaseCard

# 是否战斗中
var is_fight:bool=false

## 酒馆信息
var tavern:Tavern=preload("uid://cwx44t5ob0se1").instantiate()

# 受伤伤害计算
func player_hp_add(num:int):
	if num>0:
		hp+=num
	else:
		var temp=num
		for i in self.get_minion():
			temp=i.触发器_玩家受伤(num)
			pass
		if temp>=0:
			return
		if armor>=-temp:
			armor+=temp
		else:
			hp+=(temp+armor)


# 从手牌中使用
func user_card(card:BaseCard,targetCard:BaseCard=null):
	if card.cardType==BaseCard.CardTypeEnum.MINION:
		if get_minion().size()>=最大战场随从数量:
			print("放不下了")
			return
		add_card_in_bord(card)
		# 战吼触发
		card.触发器_战吼(self,targetCard)
	for i in get_minion():
		if i.uuid!=card.uuid:
			i.触发器_使用其他卡牌(card,self,null)
	pass
	
# 从酒馆中购买
func buy_card():
	pass

# 卡片添加到手牌中
func add_card_in_handler(card:BaseCard):
	if 手牌.size()>=最大手牌数量:
		return
	手牌.append(card)
	pass

# 随从添加（分为战斗中和非战斗中）
func add_card_in_bord(card:BaseCard):
#	todo 这里判断抽取出来
	if get_minion().size()>=最大战场随从数量:
		print("放不下了")
		return
	if beat_attack>0:
		if card.race.has(BaseCard.RaceEnum.BEAST):
			card.属性加成.append(AttributeBonus.create("哼鸣蜂鸟专属",beat_attack,0,"哼鸣蜂鸟专属"))
	# 如果这里需要选择右方
	get_minion().append(card)
	for i in get_minion():
		if i.uuid!=card.uuid:
			i.触发器_召唤他人(card,self)
	pass

# 随从移除
func remove_card(card:BaseCard):
	var index=_find_minion_index(get_minion(),card)
	if index<0:
		print("没有找到")
	get_minion().remove_at(index)
	pass

func _find_minion_index(list:Array[BaseCard],card:BaseCard)->int:
	return list.find_custom(card.uuid_eq.bind())

func find_minion(card:BaseCard)->BaseCard:
	return get_minion().get(_find_minion_index(get_minion(),card))

# 获取战场上的随从（分为战斗中和非战斗中）
func get_minion()->Array[BaseCard]:
	if is_fight:
		return 战斗中的牌
	return 战场中的牌
	

## 获取相邻的随从
func get_neighboring_minion(card:BaseCard)->Array[BaseCard]:
	var temp:Array[BaseCard]=[]
	temp.append_array(ArrayUtils.get_neighboring_data(card,get_minion()))
	return  temp 


func minion_property_func(card:BaseCard,call:Callable,permanently:bool=false):
	# 战斗中看permanently
	# 非战斗中就是永久
	var index=_find_minion_index(get_minion(),card)
	if index<0:
		print("没找到")
	else:
		var find_card=get_minion().get(index)
		call.call(find_card)
	if is_fight:
		if permanently:
			index=_find_minion_index(战场中的牌,card)
			if index<0:
				print("没找到")
			else:
				var find_card=战场中的牌.get(index)
				call.call(find_card)
	pass

func start_fight():
	is_fight=true
	战斗中的牌.clear()
	for i in 战场中的牌:
		var copy=i.copy()
		战斗中的牌.append(copy)
	for i in 战斗中的牌:
		i.触发器_战斗开始时(self)
	pass


func do_fight(target:Player):
	# 1、判断先手，谁的随从多谁先手
	# 2、战斗开始初始化
	# 3、进行战斗
	# 4、战斗结果通知
	pass
	#if self.战场中的牌.size()>target.战场中的牌.size():
		#self.start_fight();
