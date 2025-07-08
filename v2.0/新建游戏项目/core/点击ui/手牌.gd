extends HBoxContainer

func 添加到容器(拖拽节点:Card,index):
	拖拽节点.card_data.所在位置=Enums.CardPosition.手牌
	if 拖拽节点.get_parent():
		拖拽节点.reparent(self)
	else:
		add_child(拖拽节点)
	move_child(拖拽节点,index)
