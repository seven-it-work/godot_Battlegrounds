extends GutTest

func test_亡语():
	var data = preload("uid://c45nvb7wyi311").instantiate()
	var player=preload("uid://duyyralberadj").instantiate()
	player.is_fight=true
	var d=preload("uid://b0g82o30tb7kq").instantiate()
	player.add_card_in_bord(d)
	
	player.add_card_in_bord(data)
	d.dead(player)
	
	assert_eq(8+4,data.chu_shou_atk)
	pass
