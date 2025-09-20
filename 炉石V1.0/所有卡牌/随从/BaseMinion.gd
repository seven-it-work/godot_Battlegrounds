extends CardEntity
class_name BaseMinion

## 种族
@export var race:Array[Enums.CardRace]=[Enums.CardRace.无]
## 限定类型
@export var 限定类型:Array[Enums.CardRace]=[]
## 基础攻击力、生命值
@export var atk_hp:Vector2i=Vector2i(0,0)
## 当前生命值（战斗开始时会进行重置）
@export var current_hp:int=0
## 临时关键词
@export var 临时关键词:Array[String]=[]
var 攻击过了关键词失效:Array[String]=[]
@export var 战吼:Array[Roar]=[]
@export var 亡语:Array[Deathrattle]=[]
@export var 出售金币:int=1;

static var 关键词=["嘲讽","复生","圣盾","剧毒","风怒","潜行"]
@export var 嘲讽:bool=false
## 特供给一个法术
@export var 移除嘲讽:bool=false
@export var 复生:bool=false
@export var 圣盾:bool=false
## 一次性毒
@export var 剧毒:bool=false
## 永久毒
@export var 烈毒:bool=false
@export var 风怒:bool=false
@export var 超级风怒:bool=false
@export var 潜行:bool=false

@export var 是否为磁力:bool=false
@export var 磁力可以贴加的种族:Array[Enums.CardRace]=[Enums.CardRace.机械]
@export var 是否已经作为磁力:bool=false
@export var 已经贴了的磁力:Array[BaseMinion]=[]
@export var 是否在战斗中:bool=false
@export var 删除前的索引=null

#region 战斗相关属性
var 是否攻击过:bool=false
#endregion

func 添加磁力(磁力随从:CardEntity,是否触发信号:bool):
	for i in 磁力随从.已经贴了的磁力:
		添加磁力(i,false)
	if 磁力随从.get_parent():
		磁力随从.reparent(self)
	else:
		add_child(磁力随从)
	磁力随从.是否已经作为磁力=true
	临时关键词.append_array(磁力随从.临时关键词)
	if 磁力随从.嘲讽:
		self.嘲讽=true
	if 磁力随从.复生:
		self.复生=true
	if 磁力随从.圣盾:
		self.圣盾=true
	if 磁力随从.剧毒:
		self.剧毒=true
	if 磁力随从.烈毒:
		self.烈毒=true
	if 磁力随从.风怒:
		self.风怒=true
	if 磁力随从.超级风怒:
		self.超级风怒=true
	if 磁力随从.潜行:
		self.潜行=true
	已经贴了的磁力.append(磁力随从)
	if 是否触发信号:
		player.磁力吸附信号.emit(磁力随从)
	pass

func 攻击其他随从(防御者:BaseMinion):
	await player.fightUI.start_animation_sequence(self.get_cardUI(),防御者.get_cardUI())
	print("%s 对 %s 进行攻击"%[self.debug_str(),防御者.debug_str()])
	await 防御者.受到攻击(self)
	var 伤害=防御者.获取带加成属性().x
	await 生命扣除(防御者,伤害)
	pass

func 受到攻击(攻击者:BaseMinion):
	var 伤害=攻击者.获取带加成属性().x
	if 伤害<=0:
		return
	
	print("%s 受到 %s 攻击"%[self.debug_str(),攻击者.debug_str()])
	受到攻击触发(攻击者)
	await 生命扣除(攻击者,伤害)
	pass

func 生命扣除(攻击者:BaseMinion,扣除值:int):
	if 获取圣盾():
		if 扣除值<=0:
			return
		攻击过了关键词失效.append("圣盾")
		return
	if 攻击者.剧毒 or 攻击者.烈毒:
		if 攻击者.剧毒:
			攻击者.剧毒使用()
		await 死亡(攻击者)
		return
	current_hp-=扣除值
	
	print("%s 对 %s 造成 %s 点伤害"%[攻击者.debug_str(),self.debug_str(), 扣除值])
	if current_hp<=0:
		# 死亡
		await 死亡(攻击者)

func 剧毒使用():
	攻击过了关键词失效.append("剧毒")

func 死亡(攻击者:BaseMinion):
	print("%s 死亡"%[self.debug_str()])
	删除前的索引=player.获取卡片索引(self)
	# 死亡触发
	player.随从死亡信号.emit(self)
	# 触发亡语
	for i in 亡语:
		i.亡语执行(攻击者)
		# 亡语触发信号
	# 删除卡牌必须在亡语执行完后执行，不然找不到卡牌位置了
	await player.删除卡牌(self,Enums.CardPosition.战场,true)
	# 触发复生
	if 获取复生():
		攻击过了关键词失效.append("复生")
		pass
		return
	
#region 子类可以实现的触发方法
func 受到攻击触发(攻击者:BaseMinion):
	pass
func 战斗开始时():
	pass
#endregion

func 是否能够使用()->bool:
	return true

func 获取描述(dic:Dictionary={})->String:
	var tempDic=ObjectUtils.get_exported_properties(self)
	tempDic.merged(dic,true)
	if is_gold:
		return glod_描述.format(tempDic)
	return 描述.format(tempDic)


func 获取带加成属性()->Vector2i:
	var result=Vector2i(atk_hp)
	for i in 永久属性:
		result+=i.atk_hp
	for i in 临时属性:
		result+=i.atk_hp
	for i in 已经贴了的磁力:
		result+=i.获取带加成属性()
	# 这里是处理无论在哪里都会影响的属性效果
	if race.has(Enums.CardRace.亡灵):
		result+=player.亡灵加成
	# 星元自动机
	if self.名称=="星元自动机":
		if player.星元自动机召唤次数>0:
			result+=player.星元自动机召唤次数*Player.星元自动机基础加成
	# 甲虫
	if self.名称=="甲虫":
		result+=player.甲虫加成
	if self.卡片所在位置==Enums.CardPosition.酒馆:
		result+=player.酒馆随从永久加成
		result+=player.酒馆随从当前回合加成
	return result

func 属性加成(data:AttributeBonus,是否永久:bool):
	current_hp+=data.atk_hp.y
	super.属性加成(data,是否永久)
	player.随从属性加成信号.emit(self,data)

func 获取嘲讽()->bool:
	if 攻击过了关键词失效.has("嘲讽"):
		return false
	if 嘲讽:
		return true
	return 临时关键词.has("嘲讽")
func 获取复生()->bool:
	if 攻击过了关键词失效.has("复生"):
		return false
	if 复生:
		return true
	return 临时关键词.has("复生")
func 获取圣盾()->bool:
	if 攻击过了关键词失效.has("圣盾"):
		return false
	if 圣盾:
		return true
	return 临时关键词.has("圣盾")
func 获取剧毒()->bool:
	if 攻击过了关键词失效.has("剧毒"):
		return false
	if 剧毒:
		return true
	return 临时关键词.has("剧毒")
func 获取烈毒()->bool:
	if 烈毒:
		return true
	return 临时关键词.has("烈毒")
func 获取风怒()->bool:
	if 风怒:
		return true
	return 临时关键词.has("风怒")
func 获取超级风怒()->bool:
	if 超级风怒:
		return true
	return 临时关键词.has("超级风怒")
func 获取潜行()->bool:
	if 攻击过了关键词失效.has("潜行"):
		return false
	if 潜行:
		return true
	return 临时关键词.has("潜行")

func 获取种族str()->String:
	var str=""
	for i in race:
		var name=Enums.CardRace.keys().get(i)
		str+=name+"|"
	return str.substr(0,str.length()-1)

func debug_str()->String:
	var 属性=获取带加成属性()
	if player.是否在战斗中():
		return "%s的%s(%s/%s)"%[player.名称,名称,属性.x,current_hp]
	return "%s的%s(%s/%s)"%[player.名称,名称,属性.x,属性.y]
