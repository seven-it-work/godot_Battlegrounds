
extends BaseCard
var 刷新消耗生命值次数=0;

func 触发器_回合开始时(player:Player):
	super.触发器_回合开始时(player)
	刷新消耗生命值次数=2*(2 if is_gold else 1)
	player.刷新消耗生命值次数+=刷新消耗生命值次数
	pass

func 触发器_出售(player:Player):
	super.触发器_出售(player)
	player.刷新消耗生命值次数-=刷新消耗生命值次数
	pass

func 触发器_使用(player:Player,目标卡片:BaseCard):
	super.触发器_使用(player,目标卡片)
	刷新消耗生命值次数=2*(2 if is_gold else 1)
	pass
