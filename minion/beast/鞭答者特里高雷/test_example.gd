extends GutTest

func test_1():
	var data = preload("uid://wapjkahch28c").instantiate()
	var data2 = preload("uid://wapjkahch28c").instantiate()
	var player=preload("uid://duyyralberadj").instantiate()
	player.is_fight=true
	player.add_card_in_bord(data)
	player.add_card_in_bord(data2)
	
	data2.add_hp(data2,-1,player)
	
	assert_eq(6,data.atk)
	assert_eq(4,data.hp)
	pass
