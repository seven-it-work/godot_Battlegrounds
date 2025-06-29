extends Control
class_name Player

@onready var 酒馆:DragContainer=$"VBoxContainer/酒馆"
@onready var 战场:DragContainer=$"VBoxContainer/战场"
@onready var 手牌:DragContainer=$"VBoxContainer/手牌"

# 酒馆随从个数
const 酒馆随从个数={
	1:3,
	2:3,
	3:4,
	4:5,
	5:5,
	6:6
}

#region 玩家的基础属性
@export var 酒馆等级:int=1;
@export var 护甲值:int=0;
@export var 当前铸币:int=0;
@export var 出现法术个数:int=1;

#endregion
var 抉择是否隐藏:bool=false
var 抉择节点:Choose
var fight:Fight
var 上一个对手:Player

#region 一些特定的属性
@export var 优势压制:bool=false
@export var 分享关爱:bool=false
# 这个时时间管理选择了下回合开始时执行的触发
@export var 时间管理执行次数:int=0
@export var 下回合开始时额外获得金币数量:int=0
@export var 吞饮粘浆:CardData=null

@export var 元素酒馆加成:Array[AttributeBonus]=[]
@export var 随从酒馆加成:Array[AttributeBonus]=[]
@export var 法术加成:Array[AttributeBonus]=[]
@export var 亡灵加成:Array[AttributeBonus]=[]
@export var 甲虫加成:Array[AttributeBonus]=[]
#endregion

func _process(delta: float) -> void:
	$"Panel".visible=抉择是否隐藏

func 获取所有的牌()->Array[DragControl]:
	var all=获取战场和酒馆中的牌()
	all.append_array(手牌.获取所有节点())
	return all

func 进入战斗模式(fight:Fight):
	self.fight=fight

func 获取战场和酒馆中的牌()->Array[DragControl]:
	var all:Array[DragControl]=[]
	all.append_array(酒馆.获取所有节点())
	all.append_array(战场.获取所有节点())
	return all

func 所有的拖拽禁用或者开启(是否开启:bool):
	酒馆.是否可以拖拽=是否开启
	战场.是否可以拖拽=是否开启
	手牌.是否可以拖拽=是否开启
	for i in 获取所有的牌():
		i.容器中是否可以拖拽=是否开启

func _ready() -> void:
	Global.main_node=self
	#for i in 2 :
		#var drag=preload("uid://do8ek6iw7tisd").instantiate()
		#drag.card_data=preload("uid://bjhqpg4a8wuqj").instantiate()
		#drag.add_child(drag.card_data)
		#$"VBoxContainer/酒馆".添加到容器中(drag,-1)
	#for i in 2 :
		#var drag=preload("uid://do8ek6iw7tisd").instantiate()
		#drag.card_data=preload("uid://b3a4qbmde2b03").instantiate()
		#drag.add_child(drag.card_data)
		#$"VBoxContainer/酒馆".添加到容器中(drag,-1)
	#for i in 2 :
		#var drag=preload("uid://do8ek6iw7tisd").instantiate()
		#drag.card_data=preload("uid://cuxpxje8iycj3").instantiate()
		#drag.add_child(drag.card_data)
		#$"VBoxContainer/酒馆".添加到容器中(drag,-1)
	pass

func 是否在战斗中()->bool:
	return self.fight!=null

func 获取当前酒馆等级()->int:
	return 1;

func _on_抉择是否隐藏_pressed() -> void:
	抉择是否隐藏=false
	if 抉择节点:
		抉择节点.show()
	pass # Replace with function body.

func 添加到手牌(card:CardData):
	手牌.添加到容器中(Global.创建新卡片(card),-1)

func 随从死亡(card_data:CardData):
	var parent=card_data.get_parent()
	if parent is DragControl:
		# 2. 播放抖动动画
		await fight.溶解动画(parent)
		# 播放死亡动画
		parent.hide()
		print("死亡随从进行隐藏")
		pass
	else:
		Logger.error("错误类型，请检查")
	pass

func 刷新酒馆(条件:Array[CardFindCondition]=[]):
	酒馆.清除全部()
	var 等级限制=CardFindCondition.build("lv",酒馆等级,CardFindCondition.ConditionEnum.小于等于)
	# 先刷法术
	for i in 出现法术个数:
		pass
	var card_list=CardsUtils.find_card([
		CardsUtils.COMMON_CODITION.出现在酒馆,
		CardsUtils.COMMON_CODITION.随从,
		等级限制,
		CardFindCondition.build("version","32.2.4.221850",CardFindCondition.ConditionEnum.等于),
		#CardFindCondition.build("race",BaseCard.RaceEnum.BEAST,CardFindCondition.ConditionEnum.在)
	
	])
	var 随从个数= maxi(酒馆随从个数[酒馆等级]-出现法术个数+1,0)
	# 这里是自动下载插画
	#card_list=card_list.filter(func(card:BaseCard):
		#return !FileAccess.file_exists(card.get_插画路径())
		#)
	#随从个数=7
	for i in 随从个数:
		var data=card_list.pick_random()
		if !data:
			print("没有随从了")
			return
		var dup=data.duplicate()
		酒馆.添加到容器中(Global.创建新卡片(dup),-1)
	pass
