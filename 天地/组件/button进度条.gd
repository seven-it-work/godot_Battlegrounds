extends PanelContainer
@onready var 遮罩:=$"遮罩"
@onready var 是否自动点击:=$HBoxContainer/CheckBox
@onready var button:Button=$HBoxContainer/Button
@export var 冷却时间:float=1;
@export var but_text:String=""
var _冷却中:bool=false
signal 按钮点击
signal 冷却完成

func _process(delta: float) -> void:
	button.text=but_text
	if !$Timer.is_stopped():
		var 步长=self.size.x/冷却时间
		遮罩.size.x=self.size.x-$Timer.time_left*步长
		button.disabled=true
	pass

func _点击按钮():
	_冷却中=true
	按钮点击.emit()
	$Timer.start(冷却时间)

func _on_button_pressed() -> void:
	_点击按钮()
	pass # Replace with function body.

# 冷却完成
func _on_timer_timeout() -> void:
	遮罩.size.x=0
	_冷却中=false
	button.disabled=false
	冷却完成.emit()
	if 是否自动点击.button_pressed:
		_点击按钮()
