extends Roar

func _具体战吼方法接口():
	var contract_count: int = 1 * 触发卡.获取倍率() # 1 for normal, 2 for golden
	for i in contract_count:
		var contract = CardUtils.get_card('掠夺者合约', 触发卡.player)
		contract.is_gold = 触发卡.is_gold
		触发卡.player.添加卡片(contract, Enums.CardPosition.手牌, -1, true)
