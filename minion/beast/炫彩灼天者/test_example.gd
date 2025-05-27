extends GutTest

func test_1():
	var data = preload("uid://b08x00it13fep").instantiate()
	var player=preload("uid://duyyralberadj").instantiate()
	player.add_card_in_bord(data)
	var temp=data.duplicate()
	player.add_card_in_bord(temp)
	
	data.name_str="主"
	temp.name_str="受伤"
	
	player.start_fight()
	
	temp.add_hp(temp,-1,player)
	var fight_card=player.find_minion(data)
	assert_eq(5,fight_card.atk)
	assert_eq(11,fight_card.hp)
	
	assert_eq(5,data.atk)
	assert_eq(11,data.hp)
	
	pass
