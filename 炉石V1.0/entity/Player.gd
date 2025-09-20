extends Node
class_name Player

const uuid_util = preload('res://addons/uuid/uuid.gd')

static var 星元自动机基础加成:Vector2i=Vector2i(3,2)

static var 等级对应酒馆随从数量={
	1:3,
	2:4,
	3:4,
	4:5,
	5:5,
	6:6,
	7:6
}

static var 升级酒馆金币={
	1:5,
	2:7,
	3:8,
	4:9,
	5:11,
	6:12,
}

@export var 名称:String=""
@export var uuid:String=""

@export var 回合数:int=1
@export var 酒馆等级:int=1
## 特殊情况下可以变为7
@export var 最大酒馆等级:int=6
@export var 升级酒馆需要的金币:int=5

@export var 酒馆:Array=[]
@export var 战场:Array=[]
@export var 手牌:Array=[]
@export var 生命值:int=0
# 用于受伤回溯
@export var 扣除前的生命值:int=0
@export var 当前金币:int=3
@export var 当前金币上限:int=3
@export var 最大金币上限:int=10
@export var 已经花费的金币:int=0

@export var 开始回合调用方法:Array=[]
## 影响元素属性加成
@export var 元素加强加成:Vector2i=Vector2i(0,0)
@export var 元素属性加成:Vector2i=Vector2i(0,0)
@export var 鲜血宝石加成:Vector2i=Vector2i(1,1)
@export var 甲虫加成:Vector2i=Vector2i(2,2)
@export var 亡灵加成:Vector2i=Vector2(0,0)
@export var 野兽加成:Vector2i=Vector2i(0,0)
@export var 酒馆法术加成:Vector2i=Vector2i(0,0)
@export var 酒馆随从永久加成:Vector2i=Vector2i(0,0)
@export var 酒馆随从当前回合加成:Vector2i=Vector2i(0,0)
## 每召唤过一个加成+3/2（金色算两次） 如果小于0 不进行计算。
@export var 星元自动机召唤次数:int=-1

@export var 法术出现数量:int=1
@export var 刷新酒馆消耗金币:int=1
var 生命值刷新次数:Array[BaseMinion]=[]

@export var 下次购买法术金币减少数量:int=0
@export var 本局对战使用的法术数量:int=0

#region 战斗相关属性
## Array[CardEntity] （就是战场中的随从）
var 战斗中的随从:Array=[]
## key=战场上的随从 value=战斗中的随从
#var 战场_战斗中的对象映射map:Dictionary={}
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
		i.是否在战斗中=true
		i.卡片所在位置=Enums.CardPosition.战场
		i.current_hp=i.获取带加成属性().y
		战斗中的随从.append(i)
	重置攻击随从()
	pass
	
func 是否在战斗中()->bool:
	return fightUI!=null

func 战场随从是否满了()->bool:
	if 是否在战斗中():
		return 战斗中的随从.size()>=7
	return 战场.size()>=7

func 结束战斗():
	for i in 战场:
		i.是否在战斗中=false
		战斗中的随从.clear()
	fightUI=null
	pass
#endregion

signal 操作中添加卡片信号(
	d:CardEntity,
	cardPosition:Enums.CardPosition,
	index:int,
)
signal 战斗中添加卡片信号(
	d:CardEntity,
	cardPosition:Enums.CardPosition,
	index:int,
)
signal 操作中删除卡片信号(
	d:CardEntity,
	cardPosition:Enums.CardPosition,
)
signal 战斗中删除卡片信号(
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
signal 英雄受伤信号(伤害:int)
signal 随从死亡信号(死亡随从:BaseMinion)
signal 召唤随从信号(召唤随从:BaseMinion)
signal 磁力吸附信号(磁力随从:BaseMinion)
signal 酒馆刷新信号()

func 购买卡片(card:CardEntity)->bool:
	var 花费=card.获取花费()
	if 花费>当前金币:
		return false
	删除卡牌(card,Enums.CardPosition.酒馆,false)
	# 金币扣除
	if card is TavernSpell:
		下次购买法术金币减少数量=0
	花费金币(花费)
	# 这里要将酒馆加成添加进去
	card.属性加成(AttributeBonus.build("酒馆加成",酒馆随从永久加成,"酒馆加成"),true)
	card.属性加成(AttributeBonus.build("酒馆加成",酒馆随从当前回合加成,"酒馆加成"),true)
	return true

func 花费金币(花费:int):
	已经花费的金币+=花费
	当前金币-=花费
	pass

func 存档(是否为玩家存档:bool):
	# 保存数据
	var json=JSON.stringify(JsonUtils.obj2Json(self,{}))
	var path="res://save_data/%s/%s_%s.json"%[回合数,名称,uuid]
	if 是否为玩家存档:
		path="res://save_data/存档/%s_%s.json"%[名称,uuid]
	FileUtils.write_string_to_file(path,json,true)

func 读档()->Player:
	var path="res://save_data/存档/%s_%s.json"%[名称,uuid]
	if FileUtils.file_exists(path):
		var json=FileUtils.read_file_to_string(path)
		var obj=JsonUtils.json2Obj(JSON.parse_string(json),{})
		return obj as Player
	else:
		printerr("没有存档")
		return null

func 结束回合():
	回合结束信号.emit()
	存档(false)
	回合数+=1
	print("结束回合了")
	pass

func 开始回合():
	if 当前金币上限<最大金币上限:
		当前金币上限+=1
	当前金币=当前金币上限
	升级酒馆需要的金币=max(0,升级酒馆需要的金币-1)
	酒馆随从当前回合加成=Vector2i(0,0)
	# 重置生命值刷新次数
	生命值刷新次数.clear()
	# 酒馆刷新
	酒馆刷新(false)
	# 战场中的临时属性清理
	for i in 战场:
		ObjectUtils.free_obj(i.临时属性)
		ObjectUtils.free_obj(i.临时关键词)
		ObjectUtils.free_obj(i.攻击过了关键词失效)
		i.临时属性.clear()
		i.临时关键词.clear()
		i.攻击过了关键词失效.clear()
	for i in 开始回合调用方法:
		i.call()
	开始回合信号.emit()
	pass

func 是否能够手动刷新酒馆()->bool:
	if 当前金币<刷新酒馆消耗金币:
		return false
	return true

func 手动酒馆刷新():
	if !是否能够手动刷新酒馆():
		printerr("不能刷新")
		return
	
	# 检查是否还有生命值刷新次数
	if 生命值刷新次数.is_empty():
		# 扣除金币
		花费金币(刷新酒馆消耗金币)
	else:
		# 消耗生命值刷新次数，不消耗金币
		var 次数=生命值刷新次数[0].生命值刷新次数
		if 次数<0:
			printerr("错误了扣除刷新！这里不应该有这个数据")
			return
		生命值刷新次数[0].生命值刷新次数=次数-1
		if 生命值刷新次数[0].生命值刷新次数<=0:
			生命值刷新次数.pop_front()
		生命值扣除(刷新酒馆消耗金币)
	
	酒馆刷新(true)
	酒馆刷新信号.emit()
	pass

func 酒馆刷新(是否强制刷新:bool):
	var 随从list=CardUtils.find_card([
		CardUtils.COMMON_CODITION["是否出现在酒馆"],
		CardUtils.COMMON_CODITION["随从"],
		CardFindCondition.build("等级",酒馆等级,Enums.ConditionEnum.小于等于)
	])
	var 法术list=CardUtils.find_card([
		CardUtils.COMMON_CODITION["是否出现在酒馆"],
		CardUtils.COMMON_CODITION["酒馆法术"],
		CardFindCondition.build("等级",酒馆等级,Enums.ConditionEnum.小于等于)
	])
	if 是否强制刷新:
		for i in 酒馆:
			i.get_parent().queue_free()
		酒馆.clear()
		# 先添加法术
		for i in 法术出现数量:
			var card=CardUtils.get_card(法术list.pick_random().名称,self)
			self.添加卡片(card,Enums.CardPosition.酒馆,-1,true)
		for i in mini(7-法术出现数量,等级对应酒馆随从数量[酒馆等级]):
			var card=CardUtils.get_card(随从list.pick_random().名称,self)
			self.添加卡片(card,Enums.CardPosition.酒馆,-1,true)
	else:
		var 冻结的法术:Array=[]
		var 冻结的随从:Array=[]
		# 只清理没有冻结的
		for i in 酒馆:
			if i is BaseMinion:
				if i.是否冻结在酒馆:
					冻结的随从.append(i)
					continue
			if i is TavernSpell:
				if i.是否冻结在酒馆:
					冻结的法术.append(i)
					continue
			i.get_parent().queue_free()
		酒馆.clear()
		# 先添加法术
		for i in 冻结的法术:
			酒馆.append(i)
		if 冻结的法术.size()<法术出现数量:
			for i in 法术出现数量-冻结的法术.size():
				var card=CardUtils.get_card(法术list.pick_random().名称,self)
				self.添加卡片(card,Enums.CardPosition.酒馆,-1,true)
				
		for i in 冻结的随从:
			酒馆.append(i)
		var 还能添加的随从数量=mini(等级对应酒馆随从数量[酒馆等级],7-酒馆.size())
		if 冻结的随从.size()<还能添加的随从数量:
			for i in 还能添加的随从数量:
				var card=CardUtils.get_card(随从list.pick_random().名称,self)
				self.添加卡片(card,Enums.CardPosition.酒馆,-1,true)
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
	d.player=self
	d.卡片所在位置=cardPosition
	print("添加卡牌：",Enums.CardPosition.find_key(d.卡片所在位置),d.get_instance_id())
	if cardPosition==Enums.CardPosition.酒馆:
		if 酒馆.size()>=7:
			print("酒馆满了")
			return
		元素工具类.元素属性加成(d,self,true)
		index=adjust_index(index,酒馆)
		酒馆.insert(index,d)
		操作中添加卡片信号.emit(d,cardPosition,index)
		return
	if cardPosition==Enums.CardPosition.手牌:
		if 手牌.size()>=10:
			print("手牌满了")
			return
		手牌.insert(adjust_index(index,手牌),d)
		操作中添加卡片信号.emit(d,cardPosition,index)
		return
	if cardPosition==Enums.CardPosition.战场:
		if 战场随从是否满了():
			return
		var 召唤func=func():
			# 召唤随从信号
			召唤随从信号.emit(d)
			# 其他召唤的特殊处理
			if d.名称=="星元自动机":
				self.星元自动机召唤次数+=1
			if 是否触发信号:
				if 是否在战斗中():
					战斗中添加卡片信号.emit(d,cardPosition,index)
				else:
					操作中添加卡片信号.emit(d,cardPosition,index)
			pass
		
		if 是否在战斗中():
			d.current_hp=d.获取带加成属性().y
			print("添加前",战斗中的随从.map(func(c): return c.名称))
			var 索引=adjust_index(index,战斗中的随从)
			战斗中的随从.insert(索引,d)
			print("添加后",战斗中的随从.map(func(c): return c.名称))
			召唤func.call()
			return
		战场.insert(adjust_index(index,战场),d)
		召唤func.call()
		return
	printerr("错误添加卡片",d,cardPosition)
	print_stack()

## 所有的添加卡牌入口
func 删除卡牌(
	d:CardEntity,
	cardPosition:Enums.CardPosition,
	是否触发信号:bool):
	if 是否触发信号:
		print("触发删除信号 %s"%[d.debug_str()])
		if 是否在战斗中():
			战斗中删除卡片信号.emit(d,cardPosition)
		else:
			操作中删除卡片信号.emit(d,cardPosition)
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

func 生命值回溯():
	生命值=扣除前的生命值
	pass

func 生命值扣除(num:int):
	扣除前的生命值=生命值
	生命值-=num;
	英雄受伤信号.emit(num)
	pass

func 出售随从(card:CardEntity):
	删除卡牌(card,Enums.CardPosition.战场,false)
	出售随从信号.emit(card)
	if card is BaseMinion:
		# 金币获取
		当前金币+=card.出售金币

func 获取卡片索引(card:CardEntity)->int:
	if card.删除前的索引!=null and card.删除前的索引 is int:
		return card.删除前的索引
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

func _init() -> void:
	uuid=uuid_util.v4()
	pass

func 升级酒馆():
	if !是否能够升级酒馆():
		printerr("不能升级酒馆")
		return
	花费金币(升级酒馆需要的金币)
	酒馆等级+=1
	if 酒馆等级<7:
		升级酒馆需要的金币=升级酒馆金币[酒馆等级]

func 是否能够升级酒馆()->bool:
	if 当前金币<升级酒馆需要的金币:
		return false
	if 酒馆等级<最大酒馆等级:
		return true
	return false
