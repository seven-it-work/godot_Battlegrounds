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
			$Node/攻击力/Label.text="%s"%card.atk_bonus(Globals.main_node.player);
			$Node/攻击力.show()
			pass
		if card.show_hp:
			$Node/生命值/Label.text="%s"%card.hp_bonus(Globals.main_node.player);
			$Node/生命值.show()
			pass
		if card.show_buy_coins:
			$Node/金币/Label.text="%s"%card.hp_bonus(Globals.main_node.player);
			$Node/金币.show()
			pass
		
		if card.show_name_str:
			$"Node/名称/Label".text=card.name_str
			$"Node/名称".show()
		
		$Node/嘲讽.hide()
		$Node/金色边框.hide()
		$Node/普通边框.hide()
		if card.嘲讽:
			$Node/嘲讽.show()
		elif card.is_gold:
			$Node/金色边框.show()
		else:
			$Node/普通边框.show()
		if card.圣盾:
			$Node/圣盾.show()
		else:
			$Node/圣盾.hide()
		if card.冻结:
			$Node/冻结.show()
		else:
			$Node/冻结.hide()
		if card.风怒 or  card.超级风怒:
			$Node/遮罩/风怒.show()
		else:
			$Node/遮罩/风怒.hide()
		if card.潜行:
			$Node/遮罩/潜行.show()
		else:
			$Node/遮罩/潜行.hide()
		$Node/剧毒.hide()
		$Node/烈毒.hide()
		$Node/触发.hide()
		$Node/亡语.hide()
		if card.剧毒:
			$Node/剧毒.show()
		elif card.烈毒:
			$Node/烈毒.show()
		elif card.触发:
			$Node/触发.show()
		elif card.是否存在亡语():
			$Node/亡语.show()
			
			
			
			
			
func initData(card:BaseCard):
	self.card=card
	if card.show_name_str:
		$Node/名称/Label.text=card.name_str if card.name_str else card.name;
		$Node/名称.show()
	if FileAccess.file_exists(card.get_插画路径()):
		$Node/遮罩/TextureRect.texture=load(card.get_插画路径())
		pass
	else:
		if card.ls_card_id:
			# 尝试下载
			var image_url="https://art.hearthstonejson.com/v1/orig/%s.png"%card.ls_card_id
			CardsUtils.download_image(image_url,card.get_插画路径())
	if card.show_lv:
		if card.lv==1:
			$"Node/等级/1级".show()
		elif card.lv==2:
			$"Node/等级/2级".show()
		elif card.lv==3:
			$"Node/等级/3级".show()
		elif card.lv==4:
			$"Node/等级/4级".show()
		elif card.lv==5:
			$"Node/等级/5级".show()
		elif card.lv==6:
			$"Node/等级/6级".show()
		elif card.lv==7:
			$"Node/等级/7级".show()
		pass
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
		$Node/选中.show()
	else:
		
		$Node/选中.hide()
		
		
