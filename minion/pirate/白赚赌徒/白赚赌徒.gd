extends BaseCard

func 触发器_召唤(player:Player):
	self.sell_coins=6 if is_gold else 3
	pass
