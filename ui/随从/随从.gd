extends PanelContainer
class_name CardUi

enum PositionEnum{
	酒馆,
	战场,
	手牌,
}

var uuid:String=""
var card:BaseCard
var 位置:PositionEnum


@export var disable:bool=false
## 点击选中信号
signal select

func _process(delta: float) -> void:
	if disable:
		if !$disable.visible:
			$disable.show()
			select_theme_change(false)
	else:
		$disable.hide()
	if card:
		if card.show_atk:
			$Node/atk/Label.text="%s"%card.atk_bonus();
			$Node/atk.show()
		if card.show_hp:
			$Node/hp/Label.text="%s"%card.hp_bonus();
			$Node/hp.show()

func initData(card:BaseCard):
	self.card=card
	if card.show_name_str:
		$Node/name_str/Label.text=card.name_str if card.name_str else card.name;
		$Node/name_str.show()
	if FileAccess.file_exists(card.get_插画路径()):
		$TextureRect/TextureRect.texture=load(card.get_插画路径())
	if card.show_lv:
		$Node/lv/Label.text="%s"%card.lv;
		$Node/lv.show()
	pass

func _on_gui_input(event: InputEvent) -> void:
	if disable:
		return
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			select.emit()
	pass # Replace with function body.


func select_theme_change(is_selected:bool):
	if is_selected:
		add_theme_stylebox_override("panel",preload("uid://crkfgexbp8qra"))
	else:
		add_theme_stylebox_override("panel",preload("uid://cp6amf8rctaor"))
		
		
