extends PanelContainer
class_name 容器区域

@export var 可以拖入的容器:容器区域 
@onready var 碰撞区域=$Area2D
@onready var cards= $Cards
func _ready() -> void:
	pass

var _变量记录:Dictionary={
	shape_size=null,
	shape_position=null,
}

func _process(delta: float) -> void:
	if _变量记录.shape_size != self.size/(Vector2(1,1)):
		_变量记录.shape_size=self.size/(Vector2(1,1))
		$Area2D/CollisionShape2D.shape.size=_变量记录.shape_size
		$Panel.size=_变量记录.shape_size
	
	if _变量记录.shape_position != Vector2(position.x/2,position.y/2):
		_变量记录.shape_position=Vector2(position.x/2,position.y/2)
		$Area2D/CollisionShape2D.position=_变量记录.shape_position
		$Panel.position=_变量记录.shape_position

func 添加卡牌(card):
	$Cards.add_child(card)


func _on_cards_开始拖拽() -> void:
	print("开始拖拽了")
	if 可以拖入的容器:
		可以拖入的容器.设置为目标样式({quick_style={是否选中=true}})
	pass # Replace with function body.


func _on_cards_停止拖拽(card) -> void:
	print("停止拖拽了")
	if 可以拖入的容器:
		可以拖入的容器.设置为目标样式({quick_style={是否选中=false}})
	var 碰撞=card.area1.get_overlapping_areas() as Array[Area2D]
	if 碰撞.is_empty():
		pass
	else:
		if 碰撞.has(碰撞区域):
			print("自己家")
		elif 可以拖入的容器 and 碰撞.has(可以拖入的容器.碰撞区域):
			print("拖拽进入容器了")
			# 将自己的父类行更改
			card.更新容器(可以拖入的容器)
			pass
		
	pass # Replace with function body.

##
# params.bg_color 背景颜色
# quick_style:{
# 是否选中:ture
# }
func 设置为目标样式(params:Dictionary={}):
	var style=$Panel.get_theme_stylebox("panel") as StyleBoxFlat
	if params.has("quick_style"):
		var quick_style=params.quick_style
		if quick_style.has("是否选中"):
			if quick_style.是否选中:
				style.bg_color=Color(0.669, 0.61, 0.0,0.5)
			else:
				style.bg_color=Color(0.6, 0.6, 0.6, 0.0)
			pass
	
	if params.has("bg_color"):
		style.bg_color=params.bg_color
	$Panel.add_theme_stylebox_override("panel",style)
	pass
