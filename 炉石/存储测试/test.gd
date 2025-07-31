## 二进制存储总结：
## 只能存储@export的字段
## 只能存储全局class_name的定义类，内部内是不行的
## 不能存在循环依赖


extends Control
class_name  MainTest

# 可以存储
@export var test=1
# 没有@export 不能存储
var t=2
# @onready 不能存储
@onready var button:=$Button

@export var button2:Button
@export var label:Label
@export var label2:Label

## 内置脚本class_name 无法全局用
#@export var test_lei:LeiSc

@export var t_2:Lei2

## 不能保存内部内
#@export 
var temp:Temp

## 不能保存内部内
class Temp extends Node:
	@export var temp="1"
	#@export var button2:Temp2
	var temp2="2"


#class Temp2 extends Node:
	##@export var button2:Temp
	#@export var temp="2-1"
	#var temp2="2-2"

## 总结 存储只能存储@export的数据信息
func _on_button_pressed() -> void:
	t_2=Lei2.new()
	t_2.循环依赖=self
	t_2.temp="11"
	t_2.temp2="22"
	
	var temp=Temp.new()
	#var temp2=Temp2.new()
	#temp2.temp="2-11"
	#temp2.temp2="2-22"
	#temp2.button2=temp
	temp.temp="11"
	temp.temp2="22"
	#temp.button2=temp2
	
	self.temp=temp
	test=11
	t=22
	button2=$Button2
	label=$Label
	label2=Label.new()
	
	print("保存成功")
	var file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	file.store_buffer(var_to_bytes_with_objects(self))
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	print("加载成功")
	var file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var obj=bytes_to_var_with_objects(file.get_buffer(file.get_length()))
	pass # Replace with function body.
