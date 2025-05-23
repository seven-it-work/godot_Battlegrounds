extends GutTest

func test_亡语():
	var data = preload("uid://ct2kbfjpwdo0y").instantiate()
	var player=preload("uid://duyyralberadj").instantiate()
	player.add_card_in_bord(data.duplicate())
	player.add_card_in_bord(preload("uid://bxkqdswc5sqsd").instantiate())
	player.add_card_in_bord(data)
	data.dead(player)
	pass
