extends DragContainer
class_name Travern

#region 酒馆相关属性
var 酒馆等级:int=1;
var 当前金币:int=3;
var 最大铸币:int=3;
var 铸币上线自动增加剩余次数:int=10
var 升级酒馆需要的铸币:int=0
var 冻结需要的铸币:int=0
var 刷新需要的铸币:int=1
var 出现法术个数:int=1
#endregion

func 刷新(是否清空冻结随从:bool=false):
	for i in $MarginContainer/HBoxContainer.get_children():
		if 是否清空冻结随从:
			i.queue_free()
		else:
			if i is DragCard:
				if !i.baseCard.冻结:
					i.queue_free()
	# 加入新的随从
	var 随从个数= maxi(Enum.酒馆随从个数[酒馆等级]-出现法术个数+1,0)
	var 等级限制=CardFindCondition.build("lv",酒馆等级,CardFindCondition.ConditionEnum.小于等于)
		# 先刷法术
	for i in 出现法术个数:
		pass
	var card_list=CardsUtils.find_card([
		CardsUtils.COMMON_CODITION["是否出现在酒馆"],
		CardsUtils.COMMON_CODITION["随从"],
		等级限制,
		CardFindCondition.build("version","32.2.4.221850",CardFindCondition.ConditionEnum.等于),
		CardFindCondition.build("是否为伙伴",false,CardFindCondition.ConditionEnum.等于)
	])
	for i in 随从个数:
		var data=card_list.pick_random()
		if !data:
			print("没有随从了")
			return
		var ui=preload("uid://dthisa5oinhjm").instantiate()
		var dup=data.duplicate()
		ui.baseCard=dup
		添加卡片(ui,-1)

func _on_tavern_酒馆随从变化() -> void:
	for i in $MarginContainer/HBoxContainer.get_children():
		i.queue_free()
	for i in $Tavern.current_card:
		var 卡牌ui=preload("uid://dthisa5oinhjm").instantiate()
		卡牌ui.baseCard=i;
		添加卡片(卡牌ui,-1)
	pass # Replace with function body.
