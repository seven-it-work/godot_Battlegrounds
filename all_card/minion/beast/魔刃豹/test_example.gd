extends GutTest



func test_战斗平局():
	var attacker=preload("uid://duyyralberadj").instantiate()
	var defender=preload("uid://duyyralberadj").instantiate()
	var atk=preload("uid://b0g82o30tb7kq").instantiate()
	attacker.add_card_in_handler(atk)
	attacker.user_card(atk)
	
	
	var def=preload("uid://b0g82o30tb7kq").instantiate()
	defender.add_card_in_handler(def)
	defender.user_card(def)
	
	var result=Fight.build(attacker,defender).do_fight()
	assert_eq(2,attacker.get_minion().size())
	assert_eq(2,defender.get_minion().size())
	assert_eq({"是否平局":true},result)
	pass
