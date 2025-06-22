extends Control
class_name Fight

var 玩家:攻击对象
var 敌人:攻击对象


class 攻击对象:
	var player:Player
	var 当前攻击随从的索引:int=0
	func _init(player:Player) -> void:
		self.player=player
	

var 当前攻击者:攻击对象


func 开始战斗(玩家:Player,敌人:Player):
	self.玩家=攻击对象.new(玩家)
	self.敌人=攻击对象.new(敌人)
	# 判断先手,谁的怪多 谁先手
	if self.玩家.player.战场.获取所有节点().size()==self.敌人.player.战场.获取所有节点().size():
		# 一样 随机顺序
		if randi_range(0,1)==0:
			当前攻击者=self.玩家
		else:
			当前攻击者=self.敌人
	elif self.玩家.player.战场.获取所有节点().size()>self.敌人.player.战场.获取所有节点().size():
		当前攻击者=self.玩家
	else:
		当前攻击者=self.敌人
	# todo 进入战斗模式（包括战斗的计算信息）

func _process(delta: float) -> void:
	pass
