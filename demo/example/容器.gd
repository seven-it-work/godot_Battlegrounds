extends PanelContainer
class_name 容器区域

@export var 可以拖入的容器:容器区域 
@onready var 碰撞区域=$Area2D

func _ready() -> void:
	print($Area2D/CollisionShape2D.shape.get_rect())
	$Cards.检测区域=$Area2D/CollisionShape2D.shape.get_rect()
	pass

func _process(delta: float) -> void:
	$Area2D/CollisionShape2D.shape.size=self.size/(Vector2(1,2))
	$Panel.size=$Area2D/CollisionShape2D.shape.size
	
	$Area2D/CollisionShape2D.position=size*(Vector2(0,0.25))
	$Panel.position=$Area2D/CollisionShape2D.position
	
	pass

func 添加卡牌(card):
	$Cards.add_child(card)


func _on_cards_开始拖拽() -> void:
	print("开始拖拽了")
	pass # Replace with function body.


func _on_cards_停止拖拽(card) -> void:
	print("停止拖拽了")
	var 碰撞=card.area1.get_overlapping_areas() as Array[Area2D]
	if 碰撞.is_empty():
		pass
	else:
		if 碰撞.has(碰撞区域):
			print("自己家")
		elif 可以拖入的容器 and 碰撞.has(可以拖入的容器.碰撞区域):
			print("拖拽进入容器了")
			pass
		
	pass # Replace with function body.
