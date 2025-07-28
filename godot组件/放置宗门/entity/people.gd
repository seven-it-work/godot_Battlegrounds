extends Node
class_name People

@export var 操作冷却时间:int=100
@export var 操作冷却时间_计数器:int=0
@export var 伐木单位量:int=0
@export var 所在宗门:ZongMen

func _process(delta: float) -> void:
	if 操作冷却时间_计数器>0:
		操作冷却时间_计数器-=1

func 冷却():
	操作冷却时间_计数器=操作冷却时间
	pass


func 伐木():
	冷却()
	所在宗门.添加木材(伐木单位量)
	
func 探索():
	冷却()
	var 凡人数量=100
	print("发现%s个凡人，试图招揽到自己所在势力"%凡人数量)
	所在宗门.凡人数量+=凡人数量
