extends Roar

func _具体战吼方法接口():
	var buff_value: int = 1
	if 触发卡.is_gold:
		buff_value = 2

	# 在本局对战中，你的队伍酒馆中的随从拥有属性加成
	# 这里假设有一个全局的队伍酒馆随从属性加成机制
	触发卡.player.队伍酒馆随从属性加成 += Vector2i(buff_value, buff_value)
