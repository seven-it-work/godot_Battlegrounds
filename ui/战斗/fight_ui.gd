extends VBoxContainer

var 敌人:Player
var 玩家:Player


func init(player:Player,target:Player):
	self.玩家=player
	self.敌人=target
	# ui初始化
	for i in $"敌人".get_children():
		i.free()
	for i in $"玩家".get_children():
		i.free()
	var fight=Fight.build(player,target)
	var 结果=fight.do_fight()
	print(结果)
	for i in 玩家.战斗中的牌:
		var node=preload("uid://dl0ad8ft57aqx").instantiate()
		node.initData(i)
		node.位置=CardUi.PositionEnum.战场
		$"玩家".add_child(node)
	for i in 敌人.战斗中的牌:
		var node=preload("uid://dl0ad8ft57aqx").instantiate()
		node.initData(i)
		node.位置=CardUi.PositionEnum.战场
		$"敌人".add_child(node)
	pass
