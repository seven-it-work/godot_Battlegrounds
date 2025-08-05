extends DragObj
class_name CardUI

var cardData:CardEntity

static func build(cardData:CardEntity)->CardUI:
	var cardUI=preload("uid://dy3yv2yd2kdo1").instantiate()
	cardUI.cardData=cardData
	cardUI.add_child(cardData)
	return cardUI

func _process(delta: float) -> void:
	super._process(delta)
	if cardData:
		$"Control/名称/Label".text=cardData.名称
		$"Control/等级/Label".text=str(cardData.等级)
		$"Control/金币".visible=cardData.卡片所在位置==Enums.CardPosition.酒馆
		$"Control/金币/Label".text=str(cardData.花费)
		if cardData is BaseMinion:
			if !$"Control/背景图2/种族".visible:
				ArrayUtils.unique_in_place(cardData.race)
				ArrayUtils.unique_in_place(cardData.限定类型)
				var temp_种族:String=""
				$"Control/背景图2/种族".visible=true
				for i in cardData.race:
					if i==0:
						continue
					temp_种族+=Enums.CardRace.keys().get(i)+" "
				$"Control/背景图2/种族".text=temp_种族
				
			var 属性=cardData.获取带加成属性()
			$"Control/攻击力/Label".text=str(属性.x)
			$"Control/生命值/Label".text=str(属性.y)
			$"Control/背景图2/描述".text=str(cardData.获取描述())
	pass

func 待选择样式():
	var style=$PanelContainer.get_theme_stylebox("panel") as StyleBoxFlat
	style.border_color=Color(0.0, 0.954, 0.502)
	$PanelContainer.add_theme_stylebox_override("panel",style)
	pass

func 选中样式():
	var style=$PanelContainer.get_theme_stylebox("panel") as StyleBoxFlat
	style.border_color=Color(0.948, 0.786, 0.0)
	$PanelContainer.add_theme_stylebox_override("panel",style)
	pass
	
func 原始样式():
	var style=$PanelContainer.get_theme_stylebox("panel") as StyleBoxFlat
	style.border_color=Color(0.8, 0.8, 0.8)
	$PanelContainer.add_theme_stylebox_override("panel",style)
	pass
