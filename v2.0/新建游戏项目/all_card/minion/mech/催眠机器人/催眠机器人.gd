extends CardData
# <b>磁力</b>在你的回合结束时，获得+2生命值。

func 触发器_回合结束时():
	var 属性=get_AttributeBonus()
	属性.生命值+=2*(2 if is_gold else 1)
	pass
