extends Control
class_name Player

@onready var 酒馆:CardContainer=$"VBoxContainer/酒馆"
@onready var 战场:CardContainer=$"VBoxContainer/战场"
@onready var 手牌:CardContainer=$"VBoxContainer/手牌"

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
@export var 野兽加成:Array[AttributeBonus]=[]
@export var 暴吼兽王_野兽召唤个数:int=0
#endregion

#region ui操作属性
# 用于提示、操作：使用、出售等操作
var 当前的提示的卡片信息:Card
# 如果需要目标，这需要这个对象
var 当前选中的目标卡片信息:Card
# 如果存在抉择则需要这个对象
var 当前选中的抉择选项:ChooseOption
# 记录当前点击卡片的操作状态：选择目标、提示卡片、空
var 当前点击卡片属于:String="提示卡片"
#endregion



func 获取所有的牌()->Array[DragControl]:
	var all=获取战场和酒馆中的牌()
	all.append_array(手牌.获取所有节点())
	return all

func 进入战斗模式(fight:Fight):
	self.fight=fight

func 获取战场和酒馆中的牌()->Array[CardUI]:
	var all:Array[CardUI]=[]
	all.append_array(酒馆.获取所有节点())
	all.append_array(战场.获取所有节点())
	return all

func 所有的拖拽禁用或者开启(是否开启:bool):
	酒馆.是否能拖拽(是否开启)
	战场.是否能拖拽(是否开启)
	手牌.是否能拖拽(是否开启)

func _process(delta: float) -> void:
	_动态更新卡片信息()
	_动态更新按钮()

func _ready() -> void:
	$"VBoxContainer/酒馆".添加到容器(Global.创建新卡片(preload("uid://cuxpxje8iycj3").instantiate(),self),-1)
	$"VBoxContainer/酒馆".添加到容器(Global.创建新卡片(preload("uid://cptuaedglysg3").instantiate(),self),-1)
	$"VBoxContainer/酒馆".添加到容器(Global.创建新卡片(preload("uid://bjhqpg4a8wuqj").instantiate(),self),-1)

func 是否在战斗中()->bool:
	return self.fight!=null

func 获取当前酒馆等级()->int:
	return 1;



## 返回CardData
func 获取战场中的牌()->Array:
	if 是否在战斗中():
		return fight.获取自己战场中的牌(self).map(func(card:DragControl): return card.card_data)
	else:
		return 战场.获取所有节点().map(func(card:DragControl): return card.card_data)

func 添加到手牌(card:CardData):
	手牌.添加到容器(Global.创建新卡片(card,self),-1)


func 添加随从(card:CardData,index:int):
	if 是否在战斗中():
		if !fight.是否有空位(self):
			return
		_检查到召唤随从(card)
		fight.添加新牌到战场(self,Global.创建新卡片(card,self),index)
	else:
		if 战场.是否有空位():
			_检查到召唤随从(card)
			战场.添加到容器(Global.创建新卡片(card,self),index)

func _检查到召唤随从(card:CardData):
	if card.是否属于种族(Enums.RaceEnum.BEAST):
		暴吼兽王_野兽召唤个数+=1
	card.触发器_召唤()
	for i:CardData in 获取战场中的牌():
		if i.uuid!=card.uuid:
			i.触发器_召唤其他随从(card)
	pass

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
		酒馆.添加到容器(Global.创建新卡片(dup,self),-1)
	pass


#region 卡片点击相关
func 监听点击的卡片(card:CardUI):
	if 当前点击卡片属于=="选择目标":
		var card_data=当前的提示的卡片信息.card_data
		if !card_data.使用时是否需要选择目标.是否能够作为目标(card):
			return
		# 当前点击的是目标对象
		if 当前选中的目标卡片信息:
			当前选中的目标卡片信息.改变样式()
		当前选中的目标卡片信息=card
		card.改变样式("选择目标")
		return
	if 当前点击卡片属于=="提示卡片":
		打卡提示面板(card)
		card.改变样式("提示卡片")
		return
#endregion

#region 卡片提示面板操作
func 关闭提示板():
	当前点击卡片属于="提示卡片"
	$"Panel/卡片信息/ScrollContainer/HBoxContainer/抉择信息".hide()
	$"Panel/卡片信息/ScrollContainer/HBoxContainer/ScrollContainer/基本信息/Tips".hide()
	$"Panel/卡片信息/ScrollContainer/HBoxContainer/ScrollContainer/基本信息/按钮2/选择目标".hide()
	$"Panel/卡片信息/ScrollContainer/HBoxContainer/ScrollContainer/基本信息/按钮2/取消目标".hide()
	if 当前的提示的卡片信息:
		当前的提示的卡片信息.改变样式()
		当前的提示的卡片信息=null
	if 当前选中的目标卡片信息:
		当前选中的目标卡片信息.改变样式()
		当前选中的目标卡片信息=null
	当前选中的抉择选项=null
	$"Panel/卡片信息".hide()
	$"Panel/操作/VBoxContainer/使用".hide()
	$"Panel/操作/VBoxContainer/购买".hide()
	$"Panel/操作/VBoxContainer/出售".hide()

func 打卡提示面板(card:Card):
	关闭提示板()
	$"Panel/卡片信息".show()
	当前的提示的卡片信息=card
	$"Panel/卡片信息/ScrollContainer/HBoxContainer/CardUi".card_data=当前的提示的卡片信息.card_data
	$"Panel/卡片信息/ScrollContainer/HBoxContainer/CardUi".初始化卡牌信息()
	var tempCardData=当前的提示的卡片信息.card_data
	$"Panel/卡片信息/ScrollContainer/HBoxContainer/ScrollContainer/基本信息/等级/value".text="%s"%tempCardData.lv
	if tempCardData.所在位置==Enums.CardPosition.手牌:
		if tempCardData.使用时是否需要选择目标.是否需要选择目标:
			if 当前选中的目标卡片信息==null and 当前点击卡片属于!="选择目标":
				$"Panel/卡片信息/ScrollContainer/HBoxContainer/ScrollContainer/基本信息/按钮2/选择目标".show()
				$"Panel/卡片信息/ScrollContainer/HBoxContainer/ScrollContainer/基本信息/按钮2/取消目标".hide()
				if tempCardData.使用时是否需要选择目标.是否必须选中目标:
					$"Panel/卡片信息/ScrollContainer/HBoxContainer/ScrollContainer/基本信息/Tips".show()
					$"Panel/卡片信息/ScrollContainer/HBoxContainer/ScrollContainer/基本信息/Tips".text="提示：请必须选择目标！"
				else:
					$"Panel/卡片信息/ScrollContainer/HBoxContainer/ScrollContainer/基本信息/Tips".show()
					$"Panel/卡片信息/ScrollContainer/HBoxContainer/ScrollContainer/基本信息/Tips".text="提示：请选择目标！"
				
		if tempCardData.获取抉择节点():
			$"Panel/卡片信息/ScrollContainer/HBoxContainer/抉择信息".show()
			var 抉择节点=tempCardData.获取抉择节点()
			var 抉择容器=$"Panel/卡片信息/ScrollContainer/HBoxContainer/抉择信息/ScrollContainer/HBoxContainer"
			for i in 抉择容器.get_children():
				i.queue_free()
			for i in 抉择节点.获取抉择选项():
				var temp=preload("uid://qfjvvfwtyh76").instantiate()
				temp.点击信号.connect(_抉择选项点击.bind(i))
				temp.chooseOption=i
	
	_动态更新卡片信息()
	_动态更新按钮()
	
func _抉择选项点击(选项:ChooseOption):
	当前选中的抉择选项=选项
	pass

func _on_选择目标_pressed() -> void:
	当前点击卡片属于="选择目标"
	$"Panel/卡片信息/ScrollContainer/HBoxContainer/ScrollContainer/基本信息/按钮2/选择目标".hide()
	$"Panel/卡片信息/ScrollContainer/HBoxContainer/ScrollContainer/基本信息/按钮2/取消目标".show()

func _on_取消目标_pressed() -> void:
	当前点击卡片属于="提示卡片"
	if 当前选中的目标卡片信息:
		当前选中的目标卡片信息.改变样式()
		当前选中的目标卡片信息=null
	$"Panel/卡片信息/ScrollContainer/HBoxContainer/ScrollContainer/基本信息/按钮2/选择目标".show()
	$"Panel/卡片信息/ScrollContainer/HBoxContainer/ScrollContainer/基本信息/按钮2/取消目标".hide()

func _动态更新按钮():
	if !当前的提示的卡片信息:
		return
	var tempCardData=当前的提示的卡片信息.card_data	
	if tempCardData.所在位置==Enums.CardPosition.酒馆:
		$"Panel/操作/VBoxContainer/购买".show()
		$"Panel/操作/VBoxContainer/使用".hide()
		$"Panel/操作/VBoxContainer/出售".hide()
		return
	if tempCardData.所在位置==Enums.CardPosition.战场:
		$"Panel/操作/VBoxContainer/购买".hide()
		$"Panel/操作/VBoxContainer/使用".hide()
		$"Panel/操作/VBoxContainer/出售".show()
		return
	if tempCardData.所在位置==Enums.CardPosition.手牌:
		$"Panel/操作/VBoxContainer/购买".hide()
		$"Panel/操作/VBoxContainer/使用".show()
		$"Panel/操作/VBoxContainer/出售".hide()
		$"Panel/操作/VBoxContainer/使用".disabled=false
		if tempCardData.使用时是否需要选择目标.是否需要选择目标 and tempCardData.使用时是否需要选择目标.是否必须选中目标:
			$"Panel/操作/VBoxContainer/使用".disabled=当前选中的目标卡片信息==null
		if tempCardData.获取抉择节点():
			$"Panel/操作/VBoxContainer/使用".disabled=当前选中的抉择选项==null
		return
func _动态更新卡片信息():
	if !当前的提示的卡片信息:
		return
	var tempCardData=当前的提示的卡片信息.card_data
	if tempCardData.show_hp:
		$"Panel/卡片信息/ScrollContainer/HBoxContainer/ScrollContainer/基本信息/生命值/value".text="%s"%tempCardData.hp_bonus()
		var 容器=$"Panel/卡片信息/ScrollContainer/HBoxContainer/生命值/ScrollContainer/VBoxContainer/属性加成信息"
		for i in 容器.get_children():
			i.queue_free()
		for i in tempCardData.获取加成集合():
			var temp=preload("uid://oukjyykdog7f").instantiate()
			temp.展示类型="hp"
			temp.attributeBonus=i
			容器.add_child(temp)
	if tempCardData.show_atk:
		$"Panel/卡片信息/ScrollContainer/HBoxContainer/ScrollContainer/基本信息/攻击力/value".text="%s"%tempCardData.atk_bonus()
		var 容器=$"Panel/卡片信息/ScrollContainer/HBoxContainer/攻击值/ScrollContainer/VBoxContainer/属性加成信息"
		for i in 容器.get_children():
			i.queue_free()
		for i in tempCardData.获取加成集合():
			var temp=preload("uid://oukjyykdog7f").instantiate()
			temp.展示类型="atk"
			temp.attributeBonus=i
			容器.add_child(temp)
	$"Panel/卡片信息/ScrollContainer/HBoxContainer/描述".text=tempCardData.get_desc({})

#endregion

#region 操作按钮交互
func _on_使用_pressed() -> void:
	# 特殊校验:
	assert(当前的提示的卡片信息,"当前的提示的卡片信息 必须存在！")
	var cardData=当前的提示的卡片信息.card_data as CardData
	if cardData.使用时是否需要选择目标.是否必须选中目标 and cardData.使用时是否需要选择目标.是否需要选择目标:
		assert(当前选中的目标卡片信息,"当前选中的目标卡片信息 必须存在！")
	var 抉择=cardData.获取抉择节点()
	if 抉择:
		assert(当前选中的抉择选项,"当前选中的抉择选项 必须存在！")
		#当前选中的抉择选项.执行方法(self,当前的提示的卡片信息)
	else:
		cardData.使用触发()
	# 如果是法术牌则消失
	# 如果是随从牌则加入战场
	$"VBoxContainer/战场".添加到容器(cardData.get_parent(),-1)
	# 清理操作
	关闭提示板()
	$"Panel/操作/VBoxContainer/使用".hide()
func _on_购买_pressed() -> void:
	# 扣除金币
	$"VBoxContainer/手牌".添加到容器(当前的提示的卡片信息,-1)
	# 清理操作
	关闭提示板()
	$"Panel/操作/VBoxContainer/购买".hide()
	pass # Replace with function body.
func _on_出售_pressed() -> void:
	# 添加金币
	当前选中的目标卡片信息.queue_free()
	# 清理操作
	当前的提示的卡片信息=null
	当前选中的目标卡片信息=null
	当前的提示的卡片信息=null
	$"Panel/操作/VBoxContainer/购买".hide()
	pass # Replace with function body.
func _on_升级酒馆_pressed() -> void:
	pass # Replace with function body.
func _on_刷新酒馆_pressed() -> void:
	pass # Replace with function body.
func _on_结束回合_pressed() -> void:
	pass # Replace with function body.
#endregion
