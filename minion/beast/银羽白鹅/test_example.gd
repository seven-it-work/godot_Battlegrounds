extends GutTest

func test_1():
	var data = preload("uid://bxraac28baubs").instantiate()
	var player=preload("uid://duyyralberadj").instantiate()
	player.is_fight=true
	player.add_card_in_bord(data)
	
	data.add_hp(data,-1,player)
	assert_eq(2,player.战斗中的牌.size())
	pass
