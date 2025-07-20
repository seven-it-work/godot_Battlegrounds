extends Node2D
class_name Fight

@export var player:BasePeople
@export var 玩家list:Array[BasePeople]=[]
@export var 敌人list:Array[BasePeople]=[]
@export var 是否暂停集气:bool=false
@onready var 玩家容器:=$"PanelContainer/HBoxContainer/玩家"
@onready var 敌人容器:=$"PanelContainer/HBoxContainer/敌人"

func _process(delta: float) -> void:
	if !$"PanelContainer/战斗结束".visible:
		if 玩家容器.get_children().is_empty():
			print("战斗结束了")
			$"PanelContainer/战斗结束/胜利".show()
			$"PanelContainer/战斗结束".show()
		elif 敌人容器.get_children().is_empty():
			print("战斗结束了")
			$"PanelContainer/战斗结束/失败".show()
			$"PanelContainer/战斗结束".show()
	pass

func _ready() -> void:
	开始战斗()
	pass

func 获取敌人(攻击者:SimplePeopleInfo):
	if 玩家容器.get_children().has(攻击者):
		return 敌人容器.get_children()
	if 敌人容器.get_children().has(攻击者):
		return 玩家容器.get_children()
	return []

func 进行攻击(攻击者:SimplePeopleInfo):
	var 敌人=获取敌人(攻击者).pick_random() as SimplePeopleInfo
	if 敌人==null:
		print("战斗结束了")
		return
	await 攻击者._攻击动画(敌人).finished
	var 伤害=randf_range(91,100)
	敌人.player.hp_current-=伤害;
	var _抖动动画= 敌人._抖动动画(0.5,伤害/敌人.player.hp_max*10)
	var _受伤动画= 敌人._受伤动画()
	var _展示伤害动画=敌人._展示伤害动画(伤害,敌人)
	await _抖动动画.finished
	await _受伤动画.finished
	await _展示伤害动画.finished
	if 敌人.player.hp_current<=0:
		await 敌人._死亡溶解效果().finished
		敌人.queue_free()
	pass

func 开始战斗():
	for i in 玩家容器.get_children():
		i.queue_free()
	for i in 敌人容器.get_children():
		i.queue_free()
	for i in 玩家list:
		var 人物信息=preload("uid://cnsuw0i6r1vtt").instantiate()
		人物信息.player=i
		人物信息.fight=self
		玩家容器.add_child(人物信息)
		
	for i in 敌人list:
		var 人物信息=preload("uid://cnsuw0i6r1vtt").instantiate()
		人物信息.player=i
		人物信息.fight=self
		敌人容器.add_child(人物信息)
	pass


func _on_打扫战场_pressed() -> void:
	# 回到主世界
	var mainNode:MainNode=preload("uid://b28mo2p4muljx").instantiate()
	player.reparent(mainNode)
	FancyFade.blurry_noise(mainNode)
	pass # Replace with function body.
