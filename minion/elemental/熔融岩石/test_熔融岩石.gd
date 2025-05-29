extends GutTest

func test_熔融岩石加成():
	var player:Player=preload("uid://duyyralberadj").instantiate()

	var 熔融岩石=preload("uid://iepxlw2m2fdu").instantiate()
	var 熔融岩石2=preload("uid://iepxlw2m2fdu").instantiate()
	player.user_card(熔融岩石)
	player.user_card(熔融岩石2)
	var list=player.get_minion()
	assert_eq(2,list.size())
	assert_eq(4,熔融岩石.hp_bonus())
	pass
