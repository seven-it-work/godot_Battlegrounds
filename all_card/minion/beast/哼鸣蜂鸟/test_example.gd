extends GutTest

func test_哼鸣蜂鸟属性加成():
	var player:Player=preload("uid://duyyralberadj").instantiate()

	var 哼鸣蜂鸟=preload("uid://q15lwiw1ep3v").instantiate()
	var 机械木马=preload("uid://portj4o2ykuh").instantiate()
	player.user_card(哼鸣蜂鸟)
	player.user_card(机械木马)
	var list=player.get_minion()
	assert_eq(2,list.size())
	
	player.start_fight()
	player.find_minion(机械木马)._dead(player)
	
	list=player.get_minion()
	assert_eq(3,list.size())
	
	for i in list:
		if i.name_str=="机械马驹":
			print(i.atk_bonus())
			assert_eq(2+1,i.atk_bonus())
			pass
	pass
