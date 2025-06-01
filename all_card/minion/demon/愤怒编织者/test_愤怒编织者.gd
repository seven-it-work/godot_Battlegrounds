extends GutTest

func test_愤怒编织者加成():
	var player:Player=preload("uid://duyyralberadj").instantiate()

	var 愤怒编织者=preload("uid://xreh6giboxbh").instantiate()
	var 挑食魔犬=preload("uid://cqpjf6q4j6f3i").instantiate()
	player.user_card(愤怒编织者)
	player.user_card(挑食魔犬)
	var list=player.get_minion()
	assert_eq(2,list.size())
	assert_eq(29,player.hp)
	pass
