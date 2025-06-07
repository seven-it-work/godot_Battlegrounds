extends GutTest


func test_三连_2个惊喜_2个战场元素():
	var player=preload("uid://duyyralberadj").instantiate()
	var 惊喜元素1=preload("uid://di3qlou151r13").instantiate()
	var 惊喜元素2=preload("uid://di3qlou151r13").instantiate()
	
	var 商贩元素=preload("uid://dqdrvaaepukqb").instantiate()
	var 旱地元素=preload("uid://dcqdisuqy8gl5").instantiate()
	
	player.add_card_in_handler(商贩元素)
	player.user_card(商贩元素)
	
	player.add_card_in_handler(旱地元素)
	player.user_card(旱地元素)
	
	player.add_card_in_handler(惊喜元素1)
	player.user_card(惊喜元素1)
	
	
	player.add_card_in_handler(惊喜元素2)
	pass

func test_三连_1个惊喜_2个战场元素():
	var player=preload("uid://duyyralberadj").instantiate()
	var 惊喜元素=preload("uid://di3qlou151r13").instantiate()
	var 商贩元素1=preload("uid://dqdrvaaepukqb").instantiate()
	var 商贩元素2=preload("uid://dqdrvaaepukqb").instantiate()
	
	player.add_card_in_handler(商贩元素1)
	player.add_card_in_handler(商贩元素2)
	player.user_card(商贩元素1)
	player.user_card(商贩元素2)
	
	player.add_card_in_handler(惊喜元素)
	pass



func test_三连_1个惊喜_2对战场元素():
	var player=preload("uid://duyyralberadj").instantiate()
	var 惊喜元素=preload("uid://di3qlou151r13").instantiate()
	var 商贩元素1=preload("uid://dqdrvaaepukqb").instantiate()
	var 商贩元素2=preload("uid://dqdrvaaepukqb").instantiate()
	
	var 旱地元素1=preload("uid://dcqdisuqy8gl5").instantiate()
	var 旱地元素2=preload("uid://dcqdisuqy8gl5").instantiate()
	
	player.add_card_in_handler(商贩元素1)
	player.add_card_in_handler(商贩元素2)
	player.user_card(商贩元素1)
	player.user_card(商贩元素2)
	
	
	player.add_card_in_handler(旱地元素1)
	player.add_card_in_handler(旱地元素2)
	player.user_card(旱地元素1)
	player.user_card(旱地元素2)
	
	player.add_card_in_handler(惊喜元素)
	pass
