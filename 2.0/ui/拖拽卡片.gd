extends Control
class_name DragCard
@export var baseCard:BaseCard

@onready var label:=$Label
var 是否为拖拽箭头:bool=false
var 是否箭头可以指向自己:bool=false
var _is_draging:bool=false
var _drag_offset

signal 拖拽开始
signal 拖拽结束

var 原有样式

func _ready() -> void:
	position=$"Node/遮罩".position
	原有样式=$Panel.get_theme_stylebox("panel") as StyleBoxFlat
	更新卡牌信息()
	pass

func 更新卡牌信息():
	if baseCard:
		if baseCard.show_name_str:
			$Node/名称/Label.text=baseCard.name_str if baseCard.name_str else baseCard.name;
			$Node/名称.show()
		if FileAccess.file_exists(baseCard.get_插画路径()):
			$Node/遮罩/TextureRect.texture=load(baseCard.get_插画路径())
			pass
		else:
			if baseCard.ls_card_id:
				# 尝试下载
				var image_url="https://art.hearthstonejson.com/v1/orig/%s.png"%baseCard.ls_card_id
				print("尝试下载插画：",image_url)
				CardsUtils.download_image(image_url,baseCard.get_插画路径())
		if baseCard.show_lv:
			if baseCard.lv==1:
				$"Node/等级/1级".show()
			elif baseCard.lv==2:
				$"Node/等级/2级".show()
			elif baseCard.lv==3:
				$"Node/等级/3级".show()
			elif baseCard.lv==4:
				$"Node/等级/4级".show()
			elif baseCard.lv==5:
				$"Node/等级/5级".show()
			elif baseCard.lv==6:
				$"Node/等级/6级".show()
			elif baseCard.lv==7:
				$"Node/等级/7级".show()
		
		if baseCard.show_atk:
			$Node/攻击力/Label.text="%s"%baseCard.atk_bonus(Globals.main_node.player);
			$Node/攻击力.show()
			pass
		if baseCard.show_hp:
			$Node/生命值/Label.text="%s"%baseCard.hp_bonus(Globals.main_node.player);
			$Node/生命值.show()
			pass
		if baseCard.show_buy_coins:
			$Node/金币/Label.text="%s"%baseCard.hp_bonus(Globals.main_node.player);
			$Node/金币.show()
			pass
		
		if baseCard.show_name_str:
			$"Node/名称/Label".text=baseCard.name_str
			$"Node/名称".show()
		
		$Node/嘲讽.hide()
		$Node/金色边框.hide()
		$Node/普通边框.hide()
		if baseCard.嘲讽:
			$Node/嘲讽.show()
		elif baseCard.is_gold:
			$Node/金色边框.show()
		else:
			$Node/普通边框.show()
		if baseCard.圣盾:
			$Node/圣盾.show()
		else:
			$Node/圣盾.hide()
		if baseCard.冻结:
			$Node/冻结.show()
		else:
			$Node/冻结.hide()
		if baseCard.风怒 or  baseCard.超级风怒:
			$Node/遮罩/风怒.show()
		else:
			$Node/遮罩/风怒.hide()
		if baseCard.潜行:
			$Node/遮罩/潜行.show()
		else:
			$Node/遮罩/潜行.hide()
		$Node/剧毒.hide()
		$Node/烈毒.hide()
		$Node/触发.hide()
		$Node/亡语.hide()
		if baseCard.剧毒:
			$Node/剧毒.show()
		elif baseCard.烈毒:
			$Node/烈毒.show()
		elif baseCard.触发:
			$Node/触发.show()
		elif baseCard.是否存在亡语():
			$Node/亡语.show()
				

			
		print("初始化")
	pass

func _process(delta: float) -> void:
	$Panel.size=size
	if _is_draging:
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			_is_draging=false
			if 是否为拖拽箭头:
				print("没用代码")
				# 是否存在目标
				#if 全局属性.箭头相关属性.箭头的结束节点:
					#print("对xx进行释放")
					#全局属性.箭头相关属性.箭头的结束节点.样式恢复()
					#全局属性.箭头相关属性.箭头的结束节点=false
				#全局属性.箭头相关属性.是否有拖拽箭头=false
				#样式恢复()
			else:
				#print("拖拽结束")
				拖拽结束.emit()
		if 是否为拖拽箭头:
			pass
		else:
			global_position= get_global_mouse_position()+_drag_offset

func 箭头被作为目标样式():
	var style = $Panel.get_theme_stylebox("panel").duplicate() as StyleBoxFlat
	style.bg_color=Color(0.753, 0.169, 0.059, 0.6)
	$Panel.add_theme_stylebox_override("panel",style)
	$"Node2D/箭头选中".show()
	pass

func 箭头启动样式():
	var style = $Panel.get_theme_stylebox("panel").duplicate() as StyleBoxFlat
	style.bg_color=Color(0.753, 0.569, 0.059, 0.6)
	$Panel.add_theme_stylebox_override("panel",style)
	$"Node2D/当前操作".show()
	pass

func 样式恢复():
	$Panel.add_theme_stylebox_override("panel",原有样式)
	for i in [$"Node2D/箭头选中",$"Node2D/当前操作"]:
		i.hide()
	pass

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT :
			_drag_offset = global_position-get_global_mouse_position()
			_is_draging=event.is_pressed()
			if _is_draging:
				if 是否为拖拽箭头:
					箭头启动样式()
					var l=Label.new()
					add_child(l)
					l.position=DisplayServer.mouse_get_position()
					全局属性.箭头相关属性.是否有拖拽箭头=true
					全局属性.箭头相关属性.箭头初始位置=get_global_mouse_position()
					全局属性.箭头相关属性.箭头的初始节点=self
				else:
					#print("拖拽开始")
					拖拽开始.emit()
				pass
			else:
				print("是否为拖拽箭头",是否为拖拽箭头)
				if 是否为拖拽箭头:
					if 全局属性.箭头相关属性.箭头的结束节点:
						print("对xx进行释放")
						全局属性.箭头相关属性.箭头的结束节点.样式恢复()
						全局属性.箭头相关属性.箭头的结束节点=false
					全局属性.箭头相关属性.是否有拖拽箭头=false
					样式恢复()
				else:
					#print("拖拽结束")
					拖拽结束.emit()
				pass
	pass # Replace with function body.


func _on_mouse_entered() -> void:
	if 全局属性:
		if 全局属性.箭头相关属性.是否有拖拽箭头:
			if 全局属性.箭头相关属性.箭头的初始节点==self:
				if !是否箭头可以指向自己:
					return
			箭头被作为目标样式()
			全局属性.箭头相关属性.箭头的结束节点=self
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	if 全局属性:
		if 全局属性.箭头相关属性.是否有拖拽箭头:
			if 全局属性.箭头相关属性.箭头的初始节点==self:
				if !是否箭头可以指向自己:
					return
			#print("我不作为目标了")
			样式恢复()
			全局属性.箭头相关属性.箭头的结束节点=null
	pass # Replace with function body.
 
