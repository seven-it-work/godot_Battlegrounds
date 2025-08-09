extends Control
class_name BaseCardUI

var cardData:CardEntity

static func build(cardData:CardEntity)->BaseCardUI:
	var temp=preload("uid://b631tye5dlbwf").instantiate()
	temp.cardData=cardData
	temp.add_child(cardData)
	return temp

func _process(delta: float) -> void:
	if cardData:
		$"名称/Label".text=cardData.名称
		$"等级/Label".text=str(cardData.等级)
		$"金币".visible=cardData.卡片所在位置==Enums.CardPosition.酒馆
		$"金币/Label".text=str(cardData.获取花费())
		if cardData is BaseMinion:
			if !$"背景图2/种族".visible:
				ArrayUtils.unique_in_place(cardData.race)
				ArrayUtils.unique_in_place(cardData.限定类型)
				var temp_种族:String=""
				$"背景图2/种族".visible=true
				for i in cardData.race:
					if i==0:
						continue
					temp_种族+=Enums.CardRace.keys().get(i)+" "
				$"背景图2/种族".text=temp_种族
				
			var 属性=cardData.获取带加成属性()
			$"攻击力/Label".text=str(属性.x)
			$"生命值/Label".text=str(属性.y)
			$"背景图2/描述".text=str(cardData.获取描述())
	pass
