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
# 一般是0~1 如果>=2 说明2个玩家都不能攻击，则为平局
var 不能攻击的玩家个数:int=0;
# 播放动画中
var 是否在播放动画:bool=false

# 如果 造成伤害=0 则认为是平局
signal 战斗结束(胜利者:攻击对象,失败者:攻击对象,造成伤害:int)


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
	if 是否在播放动画:
		# 动画处理
		pass
	else:
		if 不能攻击的玩家个数>=2:
			# 平局
			战斗结束.emit(null,null,0)
		else:
			if 当前攻击者:
				var 所有的牌=当前攻击者.player.获取战斗中的牌()
				var 防御者=玩家 if 当前攻击者==敌人 else 敌人
				if 所有的牌.size()<=0:
					战斗结束.emit(防御者,当前攻击者,_伤害计算(防御者))
					当前攻击者=null
				# 遍历获取轮到随从攻击
				var 攻击随从:DragControl=null
				for i in 所有的牌:
					if i.card_data.atk_bonus(当前攻击者.player)>0:
						攻击随从=i
						break
				if 攻击随从==null:
					# 攻击力都是0不能进行攻击了
					不能攻击的玩家个数+=1
					当前攻击者=防御者
				else:
					# 随机进行攻击
					不能攻击的玩家个数=0;
					_随从进行攻击(攻击随从,当前攻击者,防御者)
					if 攻击随从.card_data.风怒:
						_随从进行攻击(攻击随从,当前攻击者,防御者)
					if 攻击随从.card_data.超级风怒:
						_随从进行攻击(攻击随从,当前攻击者,防御者)
						_随从进行攻击(攻击随从,当前攻击者,防御者)
					当前攻击者=防御者
	pass

func _随从进行攻击(攻击随从:DragControl,攻击者:攻击对象,防御者:攻击对象):
	if 攻击随从.card_data.hp_bonus(攻击者.player)<=0:
		print("没血了，不能继续攻击了")
		return
	# 目标查询（查询嘲讽）
	var list_嘲讽=防御者.player.获取战斗中的牌().filter(func(card:DragControl): return card.card_data.嘲讽)
	if list_嘲讽.size()>0:
		# 随机选一个
		var defender_minion:DragControl=list_嘲讽.pick_random() as DragControl
		生命计算(攻击随从,攻击者,defender_minion,防御者)
		return
	# 目标查询（忽略掉潜行的）
	var list_minion=防御者.player.获取战斗中的牌().filter(func(card:DragControl): return !card.card_data.潜行)
	if list_minion.size()>0:
		# 随机选一个
		var defender_minion:DragControl=list_minion.pick_random() as DragControl
		生命计算(攻击随从,攻击者,defender_minion,防御者)
		return
	print("对方貌似没有随从了")

func 生命计算(攻击随从:DragControl,攻击者:攻击对象,防御随从:DragControl,防御者:攻击对象):
	# 攻击方生命值-
	攻击随从.card_data.hp_process(防御随从,-防御随从.card_data.atk_bonus(防御者.player),攻击者.player)
	# 防御方
	防御随从.card_data.hp_process(攻击随从,-攻击随从.card_data.atk_bonus(攻击者.player),防御者.player)

func _伤害计算(胜利者:攻击对象)->int:
	return 10
