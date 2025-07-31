extends Control


var 玩家:FightPlayer
var 敌人:FightPlayer
var 当前攻击者:FightPlayer

func 开始战斗(player:Player,target:Player):
	玩家=FightPlayer.new(player)
	敌人=FightPlayer.new(target)
	
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
		
	# 战斗随从初始化
	_初始化战斗中的牌(玩家,$"PanelContainer/VBoxContainer/玩家随从")
	_初始化战斗中的牌(敌人,$"PanelContainer/VBoxContainer/玩家随从")
	pass

func _初始化战斗中的牌(player:FightPlayer,box:HBoxContainer):
	for i in box.get_children():
		i.queue_free()
	# 获取player的战场中的随从
