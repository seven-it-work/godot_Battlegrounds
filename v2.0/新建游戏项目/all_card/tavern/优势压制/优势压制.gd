extends CardData

func 是否能够使用()->bool:
	return !player.优势压制

func 使用触发():
	super.使用触发(player)
	player.优势压制=true
	pass
