## 二进制存储总结：
## 只能存储@export的字段
## 只能存储全局class_name的定义类，内部内是不行的
## 不能存在循环依赖


extends Control
class_name  MainTest

# 可以存储
@export var test=1
@export var button:Button=Button.new()
@onready var button2:Button=$Button2


func _ready() -> void:
	print(get_property_list())
	pass

## 总结 存储只能存储@export的数据信息
func _on_button_pressed() -> void:
	print("保存成功")


func _on_button_2_pressed() -> void:
	print("加载成功")
