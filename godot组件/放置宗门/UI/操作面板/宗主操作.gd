extends GridContainer

@export var 宗主:People
@onready var 伐木:= $"伐木"
@export_enum("空闲","伐木","探索") var 当前宗主自动操作类型:String="空闲"
@onready var 是否自动操作中:=$"自动Tips"

func _process(delta: float) -> void:
	if 宗主:
		$"伐木".冷却计数器=宗主.操作冷却时间_计数器
		$"伐木".冷却时间=宗主.操作冷却时间
		$"探索".冷却计数器=宗主.操作冷却时间_计数器
		$"探索".冷却时间=宗主.操作冷却时间
		
		if 是否自动操作中.button_pressed:
			$"自动Tips".text="宗主%s中"%当前宗主自动操作类型
			_操作继续处理()
		else:
			当前宗主自动操作类型="空闲"
			$"自动Tips".text="未开启自动操作"
	pass

func _操作继续处理():
	if 宗主.操作冷却时间_计数器<=0:
		if 当前宗主自动操作类型=="伐木":
			_on_伐木_pressed()
			return
		if 当前宗主自动操作类型=="探索":
			_on_探索_pressed()
			return
			
func _on_伐木_pressed() -> void:
	if 是否自动操作中.button_pressed:
		当前宗主自动操作类型="伐木"
	宗主.伐木()
	pass # Replace with function body.


func _on_探索_pressed() -> void:
	if 是否自动操作中.button_pressed:
		当前宗主自动操作类型="探索"
	宗主.探索()
	pass # Replace with function body.
