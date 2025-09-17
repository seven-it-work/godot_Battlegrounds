extends BaseMinion

@export var DuoGameExclusive:bool = true

func 信号绑定():
	player.回合结束信号.connect(_on_回合结束)

func _on_回合结束():
	if 卡片所在位置 != Enums.CardPosition.战场:
		return

	var minions_to_buff: int = 1
	if is_gold:
		minions_to_buff = 2

	# 给队友战队中的随从获得圣盾
	var teammate_minions = player.队友.获取战场上的牌().filter(func(m): return m is BaseMinion)
	for i in range(min(minions_to_buff, teammate_minions.size())):
		(teammate_minions[i] as BaseMinion).圣盾 = true
