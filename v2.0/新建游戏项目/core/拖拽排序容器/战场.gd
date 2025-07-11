extends DragContainer
@export var player:Player
func _on_在其他容器中释放信号(拖拽: DragControl, 其他容器: DragContainer) -> void:
	拖拽.hide()
	断开信号(拖拽)
	出售触发(拖拽)
	拖拽.queue_free()
	pass # Replace with function body.

func 是否有空位()->bool:
	return $"HBoxContainer".get_children().size()<7

func 添加到容器中(拖拽节点:DragControl,index):
	if 是否有空位():
		拖拽节点.card_data.所在位置=Enums.CardPosition.战场
		添加到战场触发(拖拽节点)
		super.添加到容器中(拖拽节点,index)

func 添加到战场触发(拖拽节点:DragControl):
	print("添加到战场触发")
	if 拖拽节点.card_data.是否有战吼():
		战吼触发(拖拽节点)
		for i in self.player.获取所有的牌():
			if i!=拖拽节点:
				战吼触发监听(拖拽节点,i)
	pass

func 战吼触发(拖拽节点:DragControl):
	拖拽节点.card_data.获取战吼节点().执行战吼()
	pass

func 战吼触发监听(战吼节点:DragControl,监听节点:DragControl):
	print("战吼触发监听")
	pass


func 出售触发(拖拽节点:DragControl):
	print("出售触发")
	pass
