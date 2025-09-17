extends BaseMinion

@export var 圣盾:bool = true

func _ready():
	# Assuming player.酒馆法术属性加成 exists to track the bonus
	# For now, we'll simulate by setting a counter
	var buff_value: int = 1
	if is_gold:
		buff_value = 2
	player.酒馆法术属性加成 += Vector2i(buff_value, buff_value * 2) # +1/+2 or +2/+4
	print("胡蒙格斯触发：酒馆法术属性加成增加 %s" % Vector2i(buff_value, buff_value * 2))
