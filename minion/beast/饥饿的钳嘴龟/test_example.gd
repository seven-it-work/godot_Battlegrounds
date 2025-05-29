extends GutTest

func test_哼鸣蜂鸟属性加成():
	var player:Player=preload("uid://duyyralberadj").instantiate()

	var 饥饿的钳嘴龟=preload("uid://d2pqn855vea45").instantiate()
	var hp=饥饿的钳嘴龟.hp_bonus()
	var 机械木马=preload("uid://portj4o2ykuh").instantiate()
	player.user_card(饥饿的钳嘴龟)
	player.user_card(机械木马)
	var list=player.get_minion()
	assert_eq(2,player.get_minion().size())
	
	player.start_fight()
	player.find_minion(机械木马)._dead(player)
	
	list=player.get_minion()
	assert_eq(3,list.size())
	
	assert_eq(hp+1,饥饿的钳嘴龟.hp_bonus())
	pass
