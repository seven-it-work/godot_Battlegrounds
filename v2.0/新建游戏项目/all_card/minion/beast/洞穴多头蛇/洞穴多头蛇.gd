extends CardData

func 触发器_攻击后(被攻击者:CardData):
	var 敌人=player.fight.获取敌人(player)
	var list=敌人.获取战场中的牌()
	var 邻居=ArrayUtils.get_neighboring_data(被攻击者,list)
	for i in 邻居:
		i.hp_process(self,-atk_bonus())
		# 2. 播放抖动动画
		await player.fight.shake_panel(i.get_parent(), 0.3, 10.0, 0.8)
	pass
