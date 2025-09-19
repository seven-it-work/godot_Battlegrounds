extends Roar

func _具体战吼方法接口():
	# Assuming player.刷新酒馆() exists to refresh the tavern
	# and player.添加消耗生命值法术() exists to add health-cost spells
	player.刷新酒馆() # Refresh the tavern
	var spells_count: int = 1
	if 触发卡.is_gold:
		spells_count = 2 # Golden version adds two health-cost spells
	player.添加消耗生命值法术(spells_count) # Add health-cost spells to tavern
	print("跳跳魔犬触发：刷新酒馆并添加 %d 张消耗生命值的法术" % spells_count)
