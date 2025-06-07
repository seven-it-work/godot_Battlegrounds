extends Node2D
class_name BaseCard

enum CardTypeEnum{
	MINION,
	## 饰品
	TRINKEt,
	## 法术
	SPELL,
	## 酒馆法术
	TAVERN,
	HERO,
	HERO_POWER
}

enum RaceEnum{
	## 没有类型
	NONE,
	## 野兽
	BEAST,
	## 恶魔
	DEMON,
	## 龙
	DRAGON,
	## 元素
	ELEMENTAL,
	## 机械
	MECH,
	## 鱼人
	MURLOC,
	## 纳迦
	NAGA,
	## 海盗
	PIRATE,
	## 野猪
	QUILBOAR,
	## 亡灵
	UNDEAD,
	## 全部
	ALL,
}

var uuid:String=""
@export var version:String=""
@export var ls_card_id:String=""
@export var name_str:String=""
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
@export var cardType:CardTypeEnum=CardTypeEnum.MINION
## 是否为金色
@export var is_gold:bool=false
# 属性
@export var 嘲讽:bool=false
@export var 圣盾:bool=false
@export var 复生:bool=false
# 一次性毒
@export var 剧毒:bool=false
@export var 风怒:bool=false
@export var 潜行:bool=false

var 额外属性:Array[String]=["嘲讽","圣盾","复生","剧毒","风怒","潜行"]

# 种族
@export var race:Array[RaceEnum]=[RaceEnum.NONE]
# 限定出现种族（有这个种族才出现 none表示没有限定）
@export var 限定出现种族:Array[RaceEnum]=[RaceEnum.NONE]
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
@export var 抉择:ToChoose

# 插画路径
@export var 插画路径:String=""
@export var 文件路径:String=""
@export var 文件名:String=""
# 永久区
@export var 属性加成:Array[AttributeBonus]=[]
var 临时属性加成:Array[AttributeBonus]=[]
# 出售金额
@export var sell_coins:int=1
# 购买需要金币
@export var buy_coins:int=3
@export var show_buy_coins:bool=false
# 是否为伙伴
@export var is_companion:bool=false
@export var 复仇:int=0
var 复仇计数器:int=0
# 其他自定义扩展属性
@export var other_data:Dictionary={}

var 冻结:bool=false
var 触发:bool=false

#region 一些判断
func 是否存在亡语()->bool:
	return 亡语.size()>0

func 是否死亡(player:Player)->bool:
	return current_hp+hp_bonus(player)<=0
#endregion

#region 一些基础属性的获取方法
func get_current_hp(player:Player):
	return current_hp+hp_bonus(player);

func get_插画路径()->String:
	if 插画路径:
		return 插画路径
	if !文件路径:
		var temp= get_script().resource_path
		文件路径=temp.get_base_dir()
		文件名=temp.get_file().replace("."+temp.get_extension(),"")
	var 默认路径="%s/%s.png"%[文件路径,文件名]
	return 默认路径

func get_desc(player:Player)->String:
	var text=""
	if is_gold:
		text=gold_desc
	else:
		text=desc
	return text

## 获取攻击力（包含加成属性）
func atk_bonus(plyaer:Player)->int:
	var result=atk*(2 if is_gold else 1);
	if plyaer.is_fight():
		for i in 临时属性加成:
			result+=i.atk;
	else:
		for i in 属性加成:
			result+=i.atk;
	return result

## 获取生命值（包含加成属性）
func hp_bonus(plyaer:Player)->int:
	var result=hp*(2 if is_gold else 1);
	if plyaer.is_fight():
		for i in 临时属性加成:
			result+=i.hp;
	else:
		for i in 属性加成:
			result+=i.hp;
	return result

#endregion

func _init() -> void:
	self.uuid=UUID.v4()


## 攻击力计算
func add_atk(trigger:BaseCard,num:int,player:Player,是否永久:bool=false):
	var temp=trigger.get_AttributeBonus()
	temp.atk=num
	临时属性加成.append(temp)
	if !player.is_fight():
		属性加成.append(temp)
	elif  是否永久:
		属性加成.append(temp)

	if num>0:
		触发器_获得攻击力(trigger,num,player)
	pass

## 生命值计算
# source_card 触发卡片
# num 生命值（>0 加血）
func add_hp(trigger:BaseCard,num:int,player:Player,是否永久:bool=false):
	if num==0:
		return
	if num>=0:
		# 加生命值
		var temp=trigger.get_AttributeBonus()
		temp.hp=num
		临时属性加成.append(temp)
		if !player.is_fight():
			属性加成.append(temp)
		elif  是否永久:
			属性加成.append(temp)

		触发器_获得生命值(trigger,num,player)
	if num<=0:
		# todo 触发器_受到攻击
		if self.圣盾:
			self.圣盾=false
			return
		# 受伤了，减去生命值
		current_hp+=num
		print("%s的%s受到%s点伤害，剩余生命值%s"%[player.name_str,name_str,-num,get_current_hp(player)])
		触发器_受伤(trigger,num,player)
		for i in player.get_minion():
			if i.uuid!=self.uuid:
				i.触发器_他人受伤(trigger,self,num,player)
		if trigger.剧毒:
			self.剧毒=false
			self.current_hp=-hp_bonus(player)
		if trigger.烈毒:
			self.current_hp=-hp_bonus(player)
		# 死亡判断
		if 是否死亡(player):
			# 消灭随从触发
			# trigger.触发器_消灭随从
			# 移除自己
			player.remove_card(self)
			# 死亡
			触发器_亡语(trigger,player)
			# 如果有复生则复生触发
			if 复生:
				var new_minion=CardsUtils.find_card([
					CardFindCondition.build("name_str",name_str,CardFindCondition.ConditionEnum.等于)
				]).front()
				if new_minion:
					new_minion=CardsUtils.find_card([
						CardFindCondition.build("name_str",new_minion.name_str,CardFindCondition.ConditionEnum.等于)
					]).get(0).duplicate()
					new_minion.current_hp=1
					new_minion.复生=false
					player.add_card_in_bord(new_minion)
				else:
					print("没有找到",name_str)
					return

func get_AttributeBonus():
	# 建议子类实现
	return AttributeBonus.create(self.name_str,0,0,self.name_str)

#region 触发器
func 触发器_当在战斗中有空位时(player:Player):
	pass
func 触发器_攻击后(player:Player,攻击目标:BaseCard):
	pass
func 触发器_获得生命值(触发者:BaseCard,num:int,player:Player):
	pass
	
func 触发器_获得攻击力(触发者:BaseCard,num:int,player:Player):
	pass
	
func 触发器_他人获得攻击力(获得者:BaseCard,num:int,player:Player):
	pass

func 手牌触发器_战斗开始时(player:Player):
	pass

func 触发器_回合结束时(player:Player):
	pass

func 触发器_回合开始时(player:Player):
	pass

func 触发器_出售(player:Player):
	pass

func 触发器_玩家受伤(num:int)->int:
	return num

func 触发器_使用其他卡牌(使用的卡牌:BaseCard,player:Player,目标卡片:BaseCard):
	pass

func 触发器_使用(player:Player,目标卡片:BaseCard):
	
	pass

func 触发器_亡语触发监听(攻击者:BaseCard,死亡者:BaseCard,player:Player):
	pass

func 触发器_亡语(attaker:BaseCard,player:Player):
	if self.亡语.size()<=0:
		return
	for i in self.亡语:
		i.亡语(attaker,self,player)
		for j in player.get_minion():
			if j.uuid!=self.uuid:
				j.触发器_亡语触发监听(attaker,self,player)
	pass

func 触发器_战吼触发监听(触发者:BaseCard,player:Player):
	pass

func 触发器_战吼(player:Player,targetCard:BaseCard=null):
	if self.战吼.size()<=0:
		return
	for i in self.战吼:
		i.战吼(self,player,targetCard)
		for j in player.get_minion():
			if j.uuid!=self.uuid:
				j.触发器_战吼触发监听(self,player)
	pass

func 触发器_召唤他人(召唤card:BaseCard,player:Player):
	pass

func 触发器_召唤(player:Player):
	pass

func 触发器_他人受伤(atkker:BaseCard,injurie_card:BaseCard,num:int,player:Player):
	pass

func 触发器_受伤(atkker:BaseCard,num:int,player:Player):
	pass

func 触发器_战斗开始时(player:Player):
	pass

func 触发器_战斗结束后(player:Player):
	pass

func 触发器_复仇(palyer:Player):
	pass

func 触发器_其他随从死亡(palyer:Player,死亡随从:BaseCard):
	复仇计数器-=1
	if 复仇计数器<=0:
		复仇计数器=复仇
		触发器_复仇(palyer)
	pass

func 触发器_死亡(player:Player,攻击者:BaseCard=null):
	# 移除自己
	player.remove_card(self)
	self.触发器_亡语(攻击者,player)
	for i in player.get_minion():
		i.触发器_其他随从死亡(player,self)
	# 复生
	if self.复生:
		var temp=self.duplicate()
		player.add_card_in_bord(temp)
	pass
#endregion


## add_card_in_bord执行完后调用
## 一般是绑定player的信号
## 信号如下：召唤信息、card等受伤信号
func add_card_in_bord_end(player:Player):
	pass


func uuid_eq(other:BaseCard)->bool:
	return other.uuid==self.uuid


#region 按下相关操作

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.

#endregion

#region 功能方法

# 复制
func copy()->BaseCard:
	var d=self.duplicate()
	d.uuid=self.uuid
	return d
#endregion
