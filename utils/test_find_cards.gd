extends GutTest


func test_find_card():
	var re=CardsUtils.find_card([
		CardFindCondition.build("lv",1,CardFindCondition.ConditionEnum.小于等于)
	])
	assert_eq(1,re.get(0).lv)
