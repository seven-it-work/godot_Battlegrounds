extends Deathrattle

func _具体亡语方法接口(攻击者:CardEntity):
	var card_count: int = 1 * 触发卡.获取倍率() # 1 for normal, 2 for golden
	# Assuming there's a method to get teammate and give them deathrattle minion cards
	# This is a placeholder implementation
	print('狡捷灵蛇触发：给队友获取 %d 张亡语随从牌' % card_count)
	# if 触发卡.player.队友:
	# 	for i in card_count:
	# 		var deathrattle_card = CardUtils.get_random_deathrattle_minion(触发卡.player.队友)
	# 		触发卡.player.队友.添加卡片(deathrattle_card, Enums.CardPosition.手牌, -1, true)
