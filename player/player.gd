extends Node
class_name Player

signal summoned(card:BaseCard,player:Player)
signal 受伤触发信号(受伤card:BaseCard,攻击card:BaseCard,num:int,player:Player)

var 最大手牌数量:int=10
var 最大战场随从数量:int=7

@export var 手牌:Array[BaseCard]=[]
# 战斗中
@export var 战斗中的牌:Array[BaseCard]=[]
# 酒馆回合（非战斗中）
@export var 战场中的牌:Array[BaseCard]=[]

# 野兽额外攻击力（哼鸣蜂鸟专属）
var beat_attack:int=0

var 当前选中的随从:BaseCard

# 是否战斗中
var is_fight:bool=false

# 从手牌中使用
func user_card():
	pass
	
# 从酒馆中购买
func buy_card():
	pass

# 卡片添加到手牌中
func add_card_in_handler():
	pass

# 随从添加（分为战斗中和非战斗中）
func add_card_in_bord(card:BaseCard):
#	todo 这里判断抽取出来
	if get_minion().size()>=最大战场随从数量:
		print("放不下了")
		return
	# 如果这里需要选择右方
	get_minion().append(card)
	summoned.emit(card,self)
	# 绑定方法
	card.add_card_in_bord_end(self)
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
		i.fight_start(self)
	pass

# 用于触发受伤效果
func card受伤监听器(受伤card:BaseCard,攻击card:BaseCard,num:int):
	受伤触发信号.emit(受伤card,攻击card,num,self)
	pass

func do_fight(target:Player):
	# 1、判断先手，谁的随从多谁先手
	# 2、战斗开始初始化
	# 3、进行战斗
	# 4、战斗结果通知
	pass
	#if self.战场中的牌.size()>target.战场中的牌.size():
		#self.start_fight();
