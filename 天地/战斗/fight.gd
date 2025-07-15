extends Node2D
class_name Fight

@export var 玩家list:Array[BasePeople]=[]
@export var 敌人list:Array[BasePeople]=[]
@export var 是否暂停集气:bool=false

func _process(delta: float) -> void:
	pass

func _ready() -> void:
	pass

func 获取敌人(攻击者:SimplePeopleInfo):
	if $"Panel/玩家".get_children().has(攻击者):
		return $"Panel/敌人".get_children()
	if $"Panel/敌人".get_children().has(攻击者):
		return $"Panel/玩家".get_children()
	return []

func 进行攻击(攻击者:SimplePeopleInfo):
	var 敌人=获取敌人(攻击者).pick_random() as SimplePeopleInfo
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
		await 敌人._死亡溶解效果()
	pass

func 开始战斗(playerList:Array[BasePeople],enemyList:Array[BasePeople]):
	for i in playerList:
		玩家list.append(i)
	for i in enemyList:
		敌人list.append(i)
	
	for i in $"Panel/玩家".get_children():
		i.queue_free()
	for i in $"Panel/敌人".get_children():
		i.queue_free()
	for i in 玩家list:
		var 人物信息=preload("uid://cnsuw0i6r1vtt").instantiate()
		人物信息.player=i
		人物信息.fight=self
		$"Panel/玩家".add_child(人物信息)
		
	for i in 敌人list:
		var 人物信息=preload("uid://cnsuw0i6r1vtt").instantiate()
		人物信息.player=i
		人物信息.fight=self
		$"Panel/敌人".add_child(人物信息)
	pass
