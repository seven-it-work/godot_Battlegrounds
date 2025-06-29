extends CardData

#当你在战斗中有空位时，召唤一只3/1的野兽并使其立即攻击。
func 触发器_战斗开始时(player:Player):
	if player.是否在战斗中():
		while true:
			if player.fight.是否有空位(player):
				for i in 2 if is_gold else 1:
					print("添加成功")
					var card=Global.创建新卡片(preload("uid://dfsudmwqdq6nv").instantiate())
					card.card_data.other_data.set("召唤者",self)
					player.fight.获取攻击对象(player).有空位时立刻攻击对象.append(card)
				await get_tree().process_frame
				return
			else:
				if self.是否死亡(player):
					return
				print("等待")
				await get_tree().create_timer(0.5).timeout
	pass
