extends GutTest

func test_亡语():
	var data = preload("uid://b0g82o30tb7kq").instantiate()
	var player=preload("uid://duyyralberadj").instantiate()
	player.add_card_in_bord(data)
	data._dead(player)
	assert_eq(2,player.get_minion().size())
	pass
