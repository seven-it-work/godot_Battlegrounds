extends Control
class_name CardData

@onready var 使用时是否需要选择目标:TargetSelector=$"使用时是否需要选择目标"

@export var name_str:String
@export var 所在位置:Enums.CardPosition=Enums.CardPosition.NONE
@export var uuid:String=""
@export var version:String=""
@export var ls_card_id:String=""
@export var show_name_str:bool=true
# 等级
@export var lv:int=1
@export var show_lv:bool=true
## 攻击力
@export var atk:int=0;
@export var show_atk:bool=true
## 生命值
@export var hp:int=1
## 当前生命值（用于战斗计算，这个应该改名为受到的伤害）
@export var current_hp:int=0

@export var show_hp:bool=true
## 描述
@export var desc:String=""
@export var gold_desc:String=""
@export var cardType:Enums.CardTypeEnum=Enums.CardTypeEnum.MINION
## 是否为金色
@export var is_gold:bool=false
# 属性
@export var 嘲讽:bool=false
# 这个属性受（搞怪裤影响）
@export var 是否被取消嘲讽:bool=false
@export var 圣盾:bool=false
@export var 复生:bool=false
# 一次性毒
@export var 剧毒:bool=false
@export var 风怒:bool=false
@export var 潜行:bool=false

var 额外属性:Array[String]=["嘲讽","圣盾","复生","剧毒","风怒","潜行"]

# 种族
@export var race:Array[Enums.RaceEnum]=[Enums.RaceEnum.NONE]
# 限定出现种族（有这个种族才出现 none表示没有限定）
@export var 限定出现种族:Array[Enums.RaceEnum]=[Enums.RaceEnum.NONE]
# 特殊属性
@export var 超级风怒:bool=false
# 永久性性毒
@export var 烈毒:bool=false
@export var 是否为伙伴:bool=false
@export var 是否出现在酒馆:bool=true
@export var 磁力:bool=false

## 是否使用时是否需要选中目标
@export var need_select_target:bool=false

@export var 亡语:Array[Dead]=[]
@export var 战吼:Array[Roar]=[]
#@export var 抉择:ToChoose

# 插画路径
@export var 插画路径:String=""
@export var 文件路径:String=""
@export var 文件名:String=""
# 永久区
@export var 属性加成:Array[AttributeBonus]=[]
@export var 临时属性加成:Array[AttributeBonus]=[]
# 出售金额
@export var sell_coins:int=1
# 购买需要金币
@export var buy_coins:int=3
@export var 购买是否消耗生命值:bool=false
@export var show_buy_coins:bool=false
# 是否为伙伴
@export var is_companion:bool=false
@export var 复仇:int=0
var 复仇计数器:int=0
# 其他自定义扩展属性
@export var other_data:Dictionary={}

@export var 冻结:bool=false
@export var 触发:bool=false

var 是否攻击过:bool=false

func _ready() -> void:
	print("ready")
func _init() -> void:
	self.uuid=UUID.v4()
func get_desc(player:Player,otherJson:Dictionary={})->String:
	var playerJson:Dictionary=JsonUtils.obj_2_json(player)
	playerJson.assign(otherJson)
	if is_gold:
		return StrUtils.自定义format(gold_desc,playerJson)
	return StrUtils.自定义format(desc,playerJson)
func get_插画路径()->String:
	if 插画路径:
		return 插画路径
	if !文件路径:
		var temp= get_script().resource_path
		文件路径=temp.get_base_dir()
		文件名=temp.get_file().replace("."+temp.get_extension(),"")
	var 默认路径="%s/%s.png"%[文件路径,文件名]
	return 默认路径

func 获取额外属性个数()->int:
	var count=0;
	if self.嘲讽:
		count+=1
	if self.圣盾:
		count+=1
	if self.复生:
		count+=1
	if self.剧毒:
		count+=1
	if self.风怒:
		count+=1
	if self.潜行:
		count+=1
	return count
#region 判断方法
func 是否能够使用(player:Player)->bool:
	return true

func 是否存在亡语()->bool:
	return 亡语.size()>0

func 是否死亡(player:Player)->bool:
	return hp_bonus(player)<=0

func 是否属于种族(race:Enums.RaceEnum)->bool:
	return self.race.has(race)

func 是否为法术()->bool:
	return [Enums.CardTypeEnum.SPELL,Enums.CardTypeEnum.TAVERN].has(self.cardType)

#endregion

func 获取抉择节点()->Choose:
	var list= get_children().filter(func(x): return x is Choose)
	if list.is_empty():
		return null;
	return list[0]

#region 战吼相关操作
func 获取战吼节点()->Roar:
	var list= get_children().filter(func(x): return x is Roar)
	if list.is_empty():
		return null;
	return list[0]

func 是否有战吼()->bool:
	return 获取战吼节点()!=null

#endregion


#region 触发相关
func 使用触发监听(player:Player,使用的卡片:CardData):
	print(name_str,"使用触发监听")

func 使用触发(player:Player):
	print(name_str,"使用触发")
	pass

func 触发器_获得攻击力(触发者:CardData,num:int,player:Player):
	pass

func 触发器_亡语(触发随从:CardData,player:Player):
	if !是否存在亡语():
		return
	for i in self.亡语:
		i.亡语(触发随从,player)
		for j in player.获取战场中的牌():
			if j.uuid!=self.uuid:
				j.触发器_亡语触发监听(触发随从,self,player)
	pass
	
func 触发器_亡语触发监听(触发随从:CardData,亡语随从:CardData,player:Player):
	pass
	
func 触发器_回合结束时():
	pass
	
func 触发器_战斗开始时(player:Player):
	pass
#endregion


## 获取攻击力（包含加成属性）
func atk_bonus(plyaer:Player)->int:
	var result=atk*(2 if is_gold else 1);
	if plyaer.是否在战斗中():
		for i in 临时属性加成:
			result+=i.atk;
	else:
		for i in 属性加成:
			result+=i.atk;
	return result

## 获取生命值（包含加成属性）
func hp_bonus(plyaer:Player)->int:
	var result=hp*(2 if is_gold else 1);
	if plyaer.是否在战斗中():
		for i in 临时属性加成:
			result+=i.hp;
	else:
		for i in 属性加成:
			result+=i.hp;
	var 生命=result+current_hp
	return 生命

# 加成描述
func get_AttributeBonus()->AttributeBonus:
	# 建议子类实现
	return AttributeBonus.create(self.name_str,0,0,self.name_str)

#region 属性加成
func 属性添加(player:Player,属性:AttributeBonus,是否永久:bool=false):
	临时属性加成.append(属性)
	if !player.是否在战斗中():
		属性加成.append(属性)
	elif  是否永久:
		属性加成.append(属性)

## 攻击力
func atk_process(触发卡:CardData,num:int,player:Player,是否永久:bool=false):
	if num==0:
		return
	var temp=触发卡.card_data.get_AttributeBonus()
	temp.atk=num
	临时属性加成.append(temp)
	if !player.是否在战斗中():
		属性加成.append(temp)
	elif  是否永久:
		属性加成.append(temp)
	#if num>0:
		#触发器_获得攻击力(trigger,num,player)
	pass
	
## 生命值处理
func hp_process(触发随从:CardData,生命值加成:int,player:Player,是否永久:bool=false):
	if 生命值加成==0:
		return
	if 生命值加成>=0:
		# 生命加成
		var temp=触发随从.get_AttributeBonus()
		temp.hp=生命值加成
		临时属性加成.append(temp)
		if !player.是否在战斗中():
			属性加成.append(temp)
		elif  是否永久:
			属性加成.append(temp)
		#触发器_获得生命值(trigger,num,player)
	else:
		# todo 触发器_受到攻击
		if self.圣盾:
			self.圣盾=false
			return
		# 受伤了，减去生命值
		if 触发随从.剧毒:
			触发随从.剧毒=false
			# todo 剧毒消失触发器
			生命值加成=-hp_bonus(player)
		if 触发随从.烈毒:
			生命值加成=-hp_bonus(player)
		current_hp+=生命值加成
		#触发器_受伤(trigger,num,player)
		for i in player.获取所有的牌():
			if i.card_data.uuid!=self.uuid:
				#i.触发器_他人受伤(trigger,self,num,player)
				pass
		# 死亡判断
		if 是否死亡(player):
			# 移除自己
			await player.随从死亡(self)
			# 死亡
			触发器_亡语(触发随从,player)
			# 如果有复生则复生触发
			#if 复生:
				#var new_minion=CardsUtils.find_card([
					#CardFindCondition.build("name_str",name_str,CardFindCondition.ConditionEnum.等于)
				#]).front()
				#if new_minion:
					#new_minion=CardsUtils.find_card([
						#CardFindCondition.build("name_str",new_minion.name_str,CardFindCondition.ConditionEnum.等于)
					#]).get(0).duplicate()
					#new_minion.current_hp=1
					#new_minion.复生=false
					#player.add_card_in_bord(new_minion)
				#else:
					#print("没有找到",name_str)
					#return

	pass
#engregion
