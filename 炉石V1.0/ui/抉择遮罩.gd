extends Panel

@export var 操作回合UI:OperationUI
@onready var 抉择UI:=$PanelContainer
@onready var 抉择选项容器:=$PanelContainer/VBoxContainer/HBoxContainer
var 触发的卡片:CardUI
var _当前选中的选项:ChooseOptionUI
var 使用成功:Callable
var 取消:Callable
var player:Player
# todo 抉择完善
func 初始化(卡片:CardUI,使用成功:Callable,取消:Callable,player:Player):
	self.触发的卡片=卡片
	self.使用成功=使用成功
	self.取消=取消
	self.show()
	self.player=player
	for i in 抉择选项容器.get_children():
		i.queue_free()
	for i in 触发的卡片.cardData.抉择.chooseOption:
		var 选项=preload("uid://bjyr5im2gi512").instantiate()
		选项.初始化(i)
		选项.点击信号.connect(_选择选项.bind(选项))
		抉择选项容器.add_child(选项)
	pass

func _选择选项(option:ChooseOptionUI):
	if _当前选中的选项:
		_当前选中的选项.取消选中()
	$"PanelContainer/VBoxContainer/操作/确认".disabled=false
	_当前选中的选项=option
	_当前选中的选项.选中()
	pass


func _on_取消_pressed() -> void:
	取消.call()
	self.hide()
	pass # Replace with function body.

func _on_确认_pressed() -> void:
	var list=player.获取酒馆And战场的牌()
	self.hide()
	if _当前选中的选项.选项卡片.选择目标对象:
		var 目标list=_当前选中的选项.选项卡片.选择目标对象.获取选择的目标对象(list)
		if 目标list.is_empty():
			取消.call()
		else:
			操作回合UI.箭头遮罩.初始化(触发的卡片,目标list,使用成功,取消)
	else:
		使用成功.call()
