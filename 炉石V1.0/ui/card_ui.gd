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
		$PanelContainer/Label.text=cardData.名称
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
