extends Node
class_name ZongMen

@export var 木材存量:int=0

@export var 凡人总人数:PeopleWork
@export var 施工队:PeopleWork
@export var 空闲人员:PeopleWork

@export var 宗主:People



func 添加木材(num:int):
	木材存量+=num
	pass
