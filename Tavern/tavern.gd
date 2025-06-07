class_name Tavern extends Node2D
# 酒馆等级及其初始升级花费金币
const 酒馆等级及其初始升级花费金币={
	1:5,
	2:7,
	3:8,
	4:9,
	5:11
}
# 酒馆随从个数
const 酒馆随从个数={
	1:3,
	2:3,
	3:4,
	4:5,
	5:5,
	6:6
}
@export var lv:int=1;
# 酒馆中的随从
var current_card:Array[BaseCard]=[]
# 当前铸币
var current_coin:int=4;
# 最大铸币
var max_coin:int=0;
# 铸币上线自动增加剩余次数
var 铸币上线自动增加剩余次数:int=10
# 升级需要的铸币
var 升级需要的铸币:int=0
# 冻结需要的铸币
var 冻结需要的铸币:int=0
# 冻结需要的铸币
var 刷新需要的铸币:int=1

var 出现法术个数:int=1

#region 交互方法
func 新的开始():
	lv=1
	current_coin=4
	max_coin=4
	升级需要的铸币=酒馆等级及其初始升级花费金币[lv]
	刷新()
	pass
func 冻结():
	pass

func 升级():
	lv+=1
	升级需要的铸币=酒馆等级及其初始升级花费金币[lv]
	pass

func 刷新():
	current_card.clear()
	var 等级限制=CardFindCondition.build("lv",lv,CardFindCondition.ConditionEnum.小于等于)
	# 先刷法术
	for i in 出现法术个数:
		pass
	var card_list=CardsUtils.find_card([
		CardsUtils.COMMON_CODITION["是否出现在酒馆"],
		CardsUtils.COMMON_CODITION["随从"],
		等级限制,
		CardFindCondition.build("version","32.2.4.221850",CardFindCondition.ConditionEnum.等于),
		CardFindCondition.build("race",BaseCard.RaceEnum.BEAST,CardFindCondition.ConditionEnum.在)
	
	])
	var 随从个数= maxi(酒馆随从个数[lv]-出现法术个数+1,0)
	# 这里是自动下载插画
	#card_list=card_list.filter(func(card:BaseCard):
		#return !FileAccess.file_exists(card.get_插画路径())
		#)
	随从个数=7
	for i in 随从个数:
		var data=card_list.pick_random()
		if !data:
			print("没有随从了")
			return
		var dup=data.duplicate()
		current_card.append(dup)
	pass

func buy_card(card:BaseCard)->int:
	var index=_find_minion_index(card)
	if index<0:
		printerr("酒馆移除失败")
		return -1
	current_card.remove_at(index)
	return index
#endregion
# 获取酒馆随从
func get_all_minion()->Array[BaseCard]:
	return current_card.filter(func(card:BaseCard): return card.cardType==BaseCard.CardTypeEnum.MINION)

func _find_minion_index(card:BaseCard)->int:
	return current_card.find_custom(card.uuid_eq.bind())
