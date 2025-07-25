extends Node
class_name PlayerTemp

var 最大手牌数量:int=10
var 最大战场随从数量:int=7
@export var uuid:String=""
@export var name_str:String=""
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
@export var 回合开始时回调的方法:Array[Callable]=[]
## 回合数（生成回合数 由玩家选牌到战斗结束才+1）
@export var 回合数:int=0;


#region 全局加成
# 野兽额外攻击力（哼鸣蜂鸟专属）
var beat_attack:int=0
# 甲虫加成(atk,hp)
var 甲虫:Vector2=Vector2(2,2)
# 元素加成(atk,hp)
var 元素加成:Vector2=Vector2(0,0)
# 酒馆元素加成(atk,hp)
var 酒馆元素加成:Vector2=Vector2(0,0)
# 下一次酒馆法术花费减少
var 下一次酒馆法术花费减少:int=0
# 暴吼兽王 就是本局召唤过的野兽次数
var 暴吼兽王加成:int=0;
# 酒馆随从加成
var 酒馆随从加成:Vector2=Vector2(0,0)
# 酒馆随从临时
var 酒馆随从临时:Vector2=Vector2(0,0)
# 刷新消耗生命值次数
var 刷新消耗生命值次数:int=0
#endregion


var 当前选中的随从:BaseCard

# 是否战斗中
var fight:FightUI
var 敌人战斗list:Array[BaseCard]=[]

## 酒馆信息
var tavern:Tavern=preload("uid://cwx44t5ob0se1").instantiate()

# 酒馆的牌变化
var 酒馆的牌变化:bool=false
# 战场的牌变化
var 战场的牌变化:bool=false
# 手牌的牌变化
var 手牌的牌变化:bool=false


#region 生命周期方法组
func 回合结束时():
	# 其他开始回合效果触发
	pass
func 回合开始时():
	# 酒馆升级铸币-1
	tavern.升级需要的铸币=maxi(tavern.升级需要的铸币-1,0)
	# 上线如果可以继续+1
	if tavern.铸币上线自动增加剩余次数>0:
		tavern.铸币上线自动增加剩余次数-=1
		tavern.max_coin+=1
	# 铸币恢复
	tavern.current_coin=tavern.max_coin
	# 酒馆补充卡片
	tavern.酒馆补充卡片()
	# 技能复原
	# 其他开始回合效果触发
	酒馆的牌变化=true
	手牌的牌变化=true
	战场的牌变化=true
	pass

func start_fight(fight:FightUI):
	self.fight=fight
	战斗中的牌.clear()
	战斗中的牌.append_array(战场中的牌)
	for i in 战斗中的牌:
		i.临时属性加成.clear()
		i.属性加成.append_array(i.属性加成)
	pass

func 战斗开始时():
	for i in 战斗中的牌:
		i.触发器_战斗开始时(self)
		if 是否有空位():
			i.触发器_当在战斗中有空位时(self)
	for i in 手牌:
		i.手牌触发器_战斗开始时(self)
	

func end_fight():
	self.fight=null
	pass
#endregion

#region 一些判断
func 是否有空位()->bool:
	return get_minion().size()<7
func is_fight()->bool:
	return !!fight
func 是否可以冻结()->bool:
	return tavern.current_coin >= tavern.冻结需要的铸币
	
func 是否可以刷新()->bool:
	return tavern.current_coin >= tavern.刷新需要的铸币

func 是否可以升级()->bool:
	return tavern.current_coin >= tavern.升级需要的铸币
#endregion


#region ui操作的方法
func 新的开始():
	tavern.新的开始()
	酒馆的牌变化=true
	pass
func 开始回合():
	回合开始时()
	pass

func 结束回合():
	回合结束时()
	回合数+=1
	# 将本玩家数据存入
	var path="res://fight_ai/%s"%回合数
	DirAccess.make_dir_absolute(path)

	var save=FileAccess.open(path+"/%s_%s.save"%[name_str,uuid],FileAccess.WRITE_READ)
	save.store_var(self,true)
	pass
func 结束战斗():
	end_fight()
	回合开始时()
	pass
func 冻结():
	if 是否可以冻结():
		tavern.冻结()
	pass
func 刷新():
	if 是否可以刷新():
		# 扣除铸币
		tavern.current_coin-=tavern.刷新需要的铸币
		tavern.刷新()
		酒馆的牌变化=true
	pass
func 升级酒馆():
	if 是否可以升级():
		tavern.current_coin-=tavern.升级需要的铸币
		tavern.升级()
	pass
func buy_card(card:BaseCard):
	# 基础判断
	
	# 扣除数据（血量，金币）
	if tavern.current_coin>=card.buy_coins:
		tavern.current_coin-=card.buy_coins
	else:
		print("金币不足")
		return
	# 酒馆移除
	var index=tavern.buy_card(card)
	酒馆的牌变化=true
	# 加入手牌
	add_card_in_handler(card)
	手牌的牌变化=true
	pass

# 从手牌中使用
func user_card(card:BaseCard,targetCard:BaseCard=null):
	# 条件判断
	
	# 从手牌中去除
	var index = _find_minion_index(手牌,card)
	if index<0:
		printerr("手牌中没有找到")
	手牌.remove_at(index)
	手牌的牌变化=true
	# 随从使用逻辑
	if card.cardType==BaseCard.CardTypeEnum.MINION:
		if get_minion().size()>=最大战场随从数量:
			print("放不下了")
			return
		# 添加到战场
		add_card_in_bord(card)
		# 战吼触发
		card.触发器_战吼(self,targetCard)
	#card.触发器_使用(self,targetCard)
	战场的牌变化=true
	
	#for i in get_minion():
		#if i.uuid!=card.uuid:
			#i.触发器_使用其他卡牌(card,self,null)
	pass

func sell_card(card:BaseCard):
	var index=_find_minion_index(战场中的牌,card)
	if index<0:
		printerr("查询不到，无法出售")
		return
	# 移除
	战场中的牌.remove_at(index)
	战场的牌变化=true
	# 金币获得
	tavern.current_coin+=card.sell_coins
#endregion

# 受伤伤害计算
func player_hp_add(num:int):
	if num>0:
		hp+=num
	else:
		var temp=num
		for i in self.get_minion():
			temp=i.触发器_玩家受伤(self,num)
			pass
		if temp>=0:
			return
		if armor>=-temp:
			armor+=temp
		else:
			hp+=(temp+armor)

func 三连检测():
	if 手牌.size()+战场中的牌.size()<3:
		return
	var group:Dictionary={}
	for i in 战场中的牌:
		if i.cardType==BaseCard.CardTypeEnum.MINION:
			i.other_data["位置"]="战场中的牌"
			if group.has(i.name_str):
				group[i.name_str].list.append(i)
				group[i.name_str].是否在战场=true
			else:
				group[i.name_str]={
					list=[i],
					是否在战场=true
			}
	for i in 手牌:
		if i.cardType==BaseCard.CardTypeEnum.MINION:
			i.other_data["位置"]="手牌"
			if group.has(i.name_str):
				group[i.name_str].list.append(i)
			else:
				group[i.name_str]={
					list=[i],
					是否在战场=false
				}
	# 过滤出可以三连的key
	var keys=group.keys()
	for i in keys:
		if i=="惊喜元素":
			continue
		var list=group[i].list
		if list.size()>=3:
			continue
		var temp_card:BaseCard=list.get(0) as BaseCard
		if temp_card.race.has(BaseCard.RaceEnum.ELEMENTAL):
			if group.has("惊喜元素"):
				var 惊喜元素list=group["惊喜元素"].list
				if list.size()+惊喜元素list.size()>=3:
					continue
		group.erase(i)
	# 排序优先战场的三连（惊喜元素三连需要递归）
	var 三连list_战场上=group.values().filter(func(a): return a.是否在战场)
	_三连(三连list_战场上,group)
	var 三连list_纯手牌=group.values().filter(func(a): return !a.是否在战场)
	_三连(三连list_纯手牌,group)

func _三连(三连list:Array,三连group:Dictionary):
	for dic in 三连list:
		var list=dic.list
		if list.size()>=3:
			# 进行三连
			var temp三连集合=[]
			for i in 3:
				var tempCard=list.pop_front() as BaseCard
				temp三连集合.append(tempCard)
				三连group[tempCard.name_str].list.erase(tempCard)
				if tempCard.other_data["位置"]=="战场中的牌":
					战场中的牌.erase(tempCard)
					战场的牌变化=true
				if tempCard.other_data["位置"]=="手牌":
					手牌.erase(tempCard)
					手牌的牌变化=true
			# 获得三连
			var 三连奖励=preload("uid://b1jj8ag84p6lf").instantiate()
			三连奖励.奖励等级=mini(tavern.lv+1,6)
			# 获取对于金色卡牌
			var 金卡=CardsUtils.合成三连(temp三连集合[0],temp三连集合[1],temp三连集合[2])
			add_card_in_handler(金卡)
			add_card_in_handler(三连奖励)
		elif 三连group.has("惊喜元素") and 三连group.get("惊喜元素").list.size()>0:
			var tempCard=list.pop_front() as BaseCard
			if tempCard.name_str=="惊喜元素":
				continue
			print("获取三连")
			# 惊喜元素判断了
			var temp三连集合=[]
			var 惊喜元素list=三连group.get("惊喜元素").list
			for i in 3-惊喜元素list.size():
				tempCard=list.pop_front() as BaseCard
				temp三连集合.append(tempCard)
				三连group[tempCard.name_str].list.erase(tempCard)
				if tempCard.other_data["位置"]=="战场中的牌":
					战场中的牌.erase(tempCard)
					战场的牌变化=true
				if tempCard.other_data["位置"]=="手牌":
					手牌.erase(tempCard)
					手牌的牌变化=true
			var len=惊喜元素list.size()
			for i in len:
				var temp=惊喜元素list.pop_front()
				temp三连集合.append(temp)
				if temp.other_data["位置"]=="战场中的牌":
					战场中的牌.erase(temp)
					战场的牌变化=true
				if temp.other_data["位置"]=="手牌":
					手牌.erase(temp)
					手牌的牌变化=true
			# 获得三连
			var 三连奖励=preload("uid://b1jj8ag84p6lf").instantiate()
			三连奖励.奖励等级=mini(tavern.lv+1,6)
			# 获取对于金色卡牌
			var 金卡=CardsUtils.合成三连(temp三连集合[0],temp三连集合[1],temp三连集合[2])
			add_card_in_handler(金卡)
			add_card_in_handler(三连奖励)

# 卡片添加到手牌中
func add_card_in_handler(card:BaseCard):
	if 手牌.size()>=最大手牌数量:
		return
	手牌.append(card)
	# 3连判断
	if card.cardType==BaseCard.CardTypeEnum.MINION  and !card.is_gold:
		三连检测()
	pass

func _is_same_card(三连记录:Dictionary,card:BaseCard,list:Array,key:String):
	# 获得的牌是惊喜元素
	
	for index in list.size():
		var temp:BaseCard=list.get(index) as BaseCard
		if temp.is_gold:
			continue
		if temp.name_str==card.name_str:
			三连记录[key].append({
				index=index,card=temp
			})
		elif card.name_str=="惊喜元素" and temp.race.has(BaseCard.RaceEnum.ELEMENTAL):
			三连记录.惊喜元素数量+=1
			三连记录[key].append({
				index=index,card=temp
			})
		elif temp.name_str=="惊喜元素" and card.race.has(BaseCard.RaceEnum.ELEMENTAL):
			三连记录.惊喜元素数量+=1
			三连记录[key].append({
				index=index,card=temp
			})

# 随从添加（分为战斗中和非战斗中）
func add_card_in_bord(card:BaseCard):
#	todo 这里判断抽取出来
	if get_minion().size()>=最大战场随从数量:
		print("放不下了")
		return
	if card.race.has(BaseCard.RaceEnum.BEAST):
		暴吼兽王加成+=1
		if beat_attack>0:
			card.属性加成.append(AttributeBonus.create("哼鸣蜂鸟专属",beat_attack,0,"哼鸣蜂鸟专属"))
	card.触发器_召唤(self)
	# 如果这里需要选择右方
	get_minion().append(card)
	if is_fight():
		fight.刷新(self)
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
	# 判断否有空位
	if 是否有空位():
		for i in get_minion():
			i.触发器_当在战斗中有空位时(self)
	pass

func _find_minion_index(list:Array[BaseCard],card:BaseCard)->int:
	return list.find_custom(card.uuid_eq.bind())

func find_minion(card:BaseCard)->BaseCard:
	return get_minion().get(_find_minion_index(get_minion(),card))

# 获取战场上的随从（分为战斗中和非战斗中）
func get_minion()->Array[BaseCard]:
	if is_fight():
		return 战斗中的牌
	return 战场中的牌
	

## 获取相邻的随从
func get_neighboring_minion(card:BaseCard)->Array[BaseCard]:
	var temp:Array[BaseCard]=[]
	temp.append_array(ArrayUtils.get_neighboring_data(card,get_minion()))
	return  temp 

func _init() -> void:
	uuid=UUID.v4()
	pass
