extends GutTest

func test_测试立刻召唤():
	var player=preload("uid://duyyralberadj").instantiate()
	player.name_str="玩家"
	
	var 利牙鲷鱼:BaseCard=CardsUtils.find_card([
		CardFindCondition.build("name_str","利牙鲷鱼",CardFindCondition.ConditionEnum.等于),
	]).get(0).duplicate()
	player.add_card_in_handler(利牙鲷鱼)
	player.user_card(利牙鲷鱼)
	
	

	var player2=preload("uid://duyyralberadj").instantiate()
	player2.name_str="AI"
	
	var 甲虫=CardsUtils.find_card([
		CardFindCondition.build("name_str","甲虫",CardFindCondition.ConditionEnum.等于),
	]).get(0).duplicate() as BaseCard
	甲虫.hp=2
	甲虫.atk=3
	player2.add_card_in_handler(甲虫)
	player2.user_card(甲虫)
	
		
	甲虫=CardsUtils.find_card([
		CardFindCondition.build("name_str","甲虫",CardFindCondition.ConditionEnum.等于),
	]).get(0).duplicate() as BaseCard
	甲虫.hp=2
	甲虫.atk=3
	player2.add_card_in_handler(甲虫)
	player2.user_card(甲虫)

	var re=Fight.build(player,player2).do_fight()
	print(re)
	assert_eq(true,re["是否平局"])
	pass
