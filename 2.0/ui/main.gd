extends Control

@onready var player:Player=$Player

func _ready() -> void:
	Globals.main_node=self
	#
	#var player=preload("uid://duyyralberadj").instantiate()
	#player.name_str="测试玩家"
	#player.tavern=$"core/酒馆/Tavern"
	#self.player=player
	#player.tavern.刷新()
	player.酒馆刷新()
	pass
	


func _process(delta: float) -> void:
	if 全局属性:
		if 全局属性.箭头相关属性.是否有拖拽箭头:
			$"箭头".show()
			$"箭头".update_curve(全局属性.箭头相关属性.箭头初始位置,get_global_mouse_position())
		else:
			$"箭头".hide()
	pass


func _on_刷新_pressed() -> void:
	player.酒馆刷新()
	pass # Replace with function body.
