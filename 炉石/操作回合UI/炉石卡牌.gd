extends DragObj
class_name CardUI

@export var cardEntity:CardEntity

var player:PlayerEntity

static func build(cardEntity:CardEntity,player:PlayerEntity)->CardUI:
	var luShiCard=preload("uid://dn05m5gy122f0").instantiate()
	luShiCard.cardEntity=cardEntity
	luShiCard.player=player
	return luShiCard



func _process(delta: float) -> void:
	super._process(delta)
	if player:
		if get_global_rect().has_point(get_global_mouse_position()):
			#print("更新Tips:",name)
			# 调用更新Tips方法
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
