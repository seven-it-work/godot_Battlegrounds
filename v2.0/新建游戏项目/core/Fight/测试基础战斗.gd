extends Control

signal 战斗结束信号

func _ready() -> void:
	pass


func _on_fight_战斗结束(胜利者: RefCounted, 失败者: RefCounted, 造成伤害: int) -> void:
	print("战斗完成了")
	if 造成伤害==0:
		print("平局")
	else:
		print("胜利者",胜利者)
	$fight.是否战斗完成标志=true
	战斗结束信号.emit()
	pass # Replace with function body.
