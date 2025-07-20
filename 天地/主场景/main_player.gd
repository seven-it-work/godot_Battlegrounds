extends Camera2D
@export var player:BasePeople
# 修炼 打坐
var _当前操作状态:String=""

func _process(delta: float) -> void:
	if player:
		$"PanelContainer/VBoxContainer/HBoxContainer/操作/突破".visible=player.exp_current>=player.exp_max
		$Label.text=player.name_str.substr(0,1)
		$"PanelContainer/VBoxContainer/状态".player=player
		
		if StrUtils.is_blank(_当前操作状态):
			$"PanelContainer/VBoxContainer/HBoxContainer/操作/修炼".button.disabled=false
			$"PanelContainer/VBoxContainer/HBoxContainer/操作/打坐".button.disabled=false
		else:
			$"PanelContainer/VBoxContainer/HBoxContainer/操作/修炼".button.disabled=true
			$"PanelContainer/VBoxContainer/HBoxContainer/操作/打坐".button.disabled=true
	if Input.is_action_pressed("w"):
		self.position.y-=1
	if Input.is_action_pressed("s"):
		self.position.y+=1
	if Input.is_action_pressed("a"):
		self.position.x-=1
	if Input.is_action_pressed("d"):
		self.position.x+=1


func _on_area_2d_area_exited(area: Area2D) -> void:
	var parent=area.get_parent()
	if parent is LingLiMainNode:
		_离开到了灵力(parent)
		return
	pass # Replace with function body.

func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent=area.get_parent()
	if parent is LingLiMainNode:
		# 碰撞到了灵力()
		_碰撞到了灵力(parent)
		return
	if parent is MonsterNode:
		_遇到了怪物(parent)
		return
	pass # Replace with function body.

func _遇到了怪物(node:MonsterNode):
	node.hide()
	var fight:Fight=preload("uid://ca3lhe4kkolhq").instantiate()
	player.reparent(fight)
	fight.player=player
	for i in node.怪物列表:
		i.reparent(fight)
	FancyFade.blurry_noise(fight)
	var listP:Array[BasePeople]=[player as BasePeople]
	var listE:Array[BasePeople]=node.怪物列表
	fight.玩家list=listP
	fight.敌人list=listE
	node.queue_free()
	pass

func _碰撞到了灵力(node:LingLiMainNode):
	var 额外操作=node.节点额外操作
	额外操作.show()
	额外操作.reparent($"PanelContainer/VBoxContainer/HBoxContainer/额外操作")

func _离开到了灵力(node:LingLiMainNode):
	var 额外操作=node.节点额外操作
	if 额外操作:
		额外操作.hide()
		额外操作.reparent(node)
		node.取消()

func _on_修炼_按钮点击() -> void:
	_当前操作状态="修炼"
	player.修炼()
	# 执行修炼
	pass # Replace with function body.

func _on_修炼_冷却完成() -> void:
	_当前操作状态=""
	pass # Replace with function body.

func _on_打坐_按钮点击() -> void:
	_当前操作状态="打坐"
	player.打坐恢复()
	pass # Replace with function body.

func _on_打坐_冷却完成() -> void:
	_当前操作状态=""
	pass # Replace with function body.

func _on_突破_pressed() -> void:
	player.升级()
	pass # Replace with function body.
