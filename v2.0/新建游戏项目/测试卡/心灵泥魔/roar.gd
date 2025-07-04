extends Roar

func 执行战吼():
	if 战吼目标:
		super.执行战吼()
		print("目标:",战吼目标.card_data.name_str)
		print("执行战吼")
	pass
