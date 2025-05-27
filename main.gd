extends Control

func _ready() -> void:
	var call_func = func (arg1,arg2):
		print(type_string(typeof(arg1)))
		print(type_string(typeof(arg2)))
		print(arg1)
		print(arg2)
	do_call(call_func.bind("参数2"),"测试")
	pass


func do_call(call:Callable,arg):
	call.call("参数1")
