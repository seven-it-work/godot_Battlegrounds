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

## 点击选中信号
signal select

func initData(card:BaseCard):
	if card.show_name_str:
		$Node/name_str/Label.text=card.name_str;
		$Node/name_str.show()
	if card.show_lv:
		$Node/lv/Label.text="%s"%card.lv;
		$Node/lv.show()
	if card.show_atk:
		$Node/atk/Label.text="%s"%card.atk_bonus();
		$Node/atk.show()
	if card.show_hp:
		$Node/hp/Label.text="%s"%card.hp_bonus();
		$Node/hp.show()
	pass

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			select.emit()
	pass # Replace with function body.


func select_theme_change(is_selected:bool):
	if is_selected:
		add_theme_stylebox_override("panel",preload("uid://crkfgexbp8qra"))
	else:
		add_theme_stylebox_override("panel",preload("uid://cp6amf8rctaor"))
		
		
