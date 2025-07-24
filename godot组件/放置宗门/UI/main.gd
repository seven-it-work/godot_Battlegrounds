extends Control
# 一秒 60帧 就是60FPS
var count=0;

func _ready() -> void:
	var t=Timer.new()
	add_child(t)
	t.timeout.connect(func(): print(Global.game_data.获取时间Str()))
	t.start(1)
	t.one_shot=false
	pass

func _process(delta: float) -> void:
	Global.game_data.add_time()
	pass
