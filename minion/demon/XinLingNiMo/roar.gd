extends Roar

func do_action(trigger:BaseCard,player:Player):
	if player.is_fight:
		# 战斗中触发不了
		return
	print("选中一个")
	if player.当前选中的随从:
		print("吞食酒馆")
	else:
		print("随机择一个友方")
	pass
