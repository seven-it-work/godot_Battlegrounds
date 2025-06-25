extends Control
class_name DragControl

@export var uuid:String
@export var 是否可以拖拽:bool=true
@export var 容器中是否可以拖拽:bool=true
@export var card_data:CardData
@onready var label=$Label
var 是否按下拖拽:bool=false
var _drag_offset

signal 开始拖拽
signal 结束拖拽

func 是否可以拖拽判断()->bool:
	return 是否可以拖拽 and 容器中是否可以拖拽

func 初始化卡牌信息():
	if card_data:
		if card_data.show_name_str:
			$Node/名称/Label.text=card_data.name_str if card_data.name_str else card_data.name;
			$Node/名称.show()
		var 插画路径=card_data.get_插画路径()
		#var 插画路径="res://asserts/StealthDomeShadow_D.png"
		if FileAccess.file_exists(插画路径):
			$Node/遮罩/TextureRect.texture=load(插画路径)
			pass
		else:
			if card_data.ls_card_id:
				# 尝试下载
				var image_url="https://art.hearthstonejson.com/v1/orig/%s.png"%card_data.ls_card_id
				print("尝试下载插画：",image_url)
				CardsUtils.download_image(image_url,card_data.get_插画路径())
		if card_data.show_lv:
			if card_data.lv==1:
				$"Node/等级/1级".show()
			elif card_data.lv==2:
				$"Node/等级/2级".show()
			elif card_data.lv==3:
				$"Node/等级/3级".show()
			elif card_data.lv==4:
				$"Node/等级/4级".show()
			elif card_data.lv==5:
				$"Node/等级/5级".show()
			elif card_data.lv==6:
				$"Node/等级/6级".show()
			elif card_data.lv==7:
				$"Node/等级/7级".show()
	pass

func 更新卡牌信息():
	if card_data:
		if card_data.show_atk:
			$Node/攻击力/Label.text="%s"%card_data.atk_bonus(Global.main_node);
			$Node/攻击力.show()
			pass
		if card_data.show_hp:
			$Node/生命值/Label.text="%s"%card_data.hp_bonus(Global.main_node);
			$Node/生命值.show()
			pass
		if card_data.show_buy_coins:
			$Node/金币/Label.text="%s"%card_data.buy_coins;
			$Node/金币.show()
			pass
		
		if card_data.show_name_str:
			$"Node/名称/Label".text=card_data.name_str
			$"Node/名称".show()
		
		$Node/嘲讽.hide()
		$Node/金色边框.hide()
		$Node/普通边框.hide()
		if card_data.嘲讽:
			$Node/嘲讽.show()
		elif card_data.is_gold:
			$Node/金色边框.show()
		else:
			$Node/普通边框.show()
		if card_data.圣盾:
			$Node/圣盾.show()
		else:
			$Node/圣盾.hide()
		if card_data.冻结:
			$Node/冻结.show()
		else:
			$Node/冻结.hide()
		if card_data.风怒 or  card_data.超级风怒:
			$Node/遮罩/风怒.show()
		else:
			$Node/遮罩/风怒.hide()
		if card_data.潜行:
			$Node/遮罩/潜行.show()
		else:
			$Node/遮罩/潜行.hide()
		$Node/剧毒.hide()
		$Node/烈毒.hide()
		$Node/触发.hide()
		$Node/亡语.hide()
		if card_data.剧毒:
			$Node/剧毒.show()
		elif card_data.烈毒:
			$Node/烈毒.show()
		elif card_data.触发:
			$Node/触发.show()
		elif card_data.是否存在亡语():
			$Node/亡语.show()
	pass

func _ready() -> void:
	初始化卡牌信息()

func _process(delta: float) -> void:
	$Panel.size=custom_minimum_size
	更新卡牌信息()
	var 链接=get_signal_connection_list("结束拖拽")
	if card_data:
		uuid=card_data.uuid
		label.text=card_data.name_str
	if 是否可以拖拽判断():
		if 是否按下拖拽:
			if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				释放()
			拖拽中处理()
	pass

func 拖拽中处理():
	global_position=get_global_mouse_position()+_drag_offset
	

func 释放():
	if 是否按下拖拽:
		#print("释放")
		是否按下拖拽=false
		结束拖拽.emit()

func _on_panel_gui_input(event: InputEvent) -> void:
	if 是否可以拖拽判断():
		if event is InputEventMouseButton:
			var eventMouse=event as InputEventMouseButton
			if eventMouse.button_index==MOUSE_BUTTON_LEFT:
				if eventMouse.is_pressed():
					#print("按下")
					_drag_offset = global_position-get_global_mouse_position()
					是否按下拖拽=true
					开始拖拽.emit()
				else:
					释放()
