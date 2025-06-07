extends GutTest

func test_攻击力加成():
	var player=preload("uid://duyyralberadj").instantiate()
	player.name_str="玩家"

	
	var 威严猛虎:BaseCard=CardsUtils.find_card([
		CardFindCondition.build("name_str","威严猛虎",CardFindCondition.ConditionEnum.等于),
	]).get(0).duplicate()
	player.add_card_in_handler(威严猛虎)
	player.user_card(威严猛虎)
	
	var 丝柔烁光蛾=CardsUtils.find_card([
		CardFindCondition.build("name_str","丝柔烁光蛾",CardFindCondition.ConditionEnum.等于),
	]).get(0).duplicate()
	player.add_card_in_handler(丝柔烁光蛾)
	player.user_card(丝柔烁光蛾)
	
	var 甲虫=CardsUtils.find_card([
		CardFindCondition.build("name_str","甲虫",CardFindCondition.ConditionEnum.等于),
	]).get(0).duplicate() as BaseCard
	甲虫.hp=99
	甲虫.atk=10
	var player2=preload("uid://duyyralberadj").instantiate()
	player2.name_str="AI"
	player2.add_card_in_handler(甲虫)
	player2.user_card(甲虫)
	
	print(Fight.build(player,player2).do_fight())
	assert_eq(4,player.甲虫.x)
	assert_eq(4,player.甲虫.y)
	assert_eq(99-5-12-4,甲虫.get_current_hp(player2))
	pass
