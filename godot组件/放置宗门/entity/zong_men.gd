extends Node
class_name ZongMen

@export var 木材存量:int=0
@export var 凡人数量:int=0
@export var 最大凡人数量:int=10
# 每600次清理一次凡人数量（如果没有足够住房，多余人将被清理）
@export var 凡人数量清理_计算器:int=0
@export var 宗主:People

func _process(delta: float) -> void:
	if 凡人数量清理_计算器<=0:
		_清理凡人()
	else:
		凡人数量清理_计算器-=1

func _清理凡人():
	if 凡人数量>最大凡人数量:
		print("有%s个凡人没有住房离开了"%(最大凡人数量-凡人数量))
		凡人数量=最大凡人数量
	凡人数量清理_计算器=600
	pass

func 添加木材(num:int):
	木材存量+=num
	pass
