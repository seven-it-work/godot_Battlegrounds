extends Roar

func _具体战吼方法接口():
	# Assuming '燃翼' is the token name for the minion
	var smolderwing = CardUtils.get_card('燃翼', 触发卡.player)
	if smolderwing and smolderwing is BaseMinion:
		# Set the stats and battlecry for the smolderwing
		(smolderwing as BaseMinion).基础攻击力 = 2
		(smolderwing as BaseMinion).基础生命值 = 1
		(smolderwing as BaseMinion).is_gold = 触发卡.is_gold
		
		# Add battlecry to buff dragons
		var roar_node = Roar.new()
		smolderwing.add_child(roar_node)
		roar_node.触发卡 = smolderwing
		roar_node.script = preload("res://所有卡牌/随从/龙/达基萨斯将军/燃翼_Roar.gd")
		(smolderwing as BaseMinion).战吼.append(roar_node)
		
		触发卡.player.添加卡片(smolderwing, Enums.CardPosition.手牌, -1, true) # Add to hand
		print("达基萨斯将军触发：获取燃翼")
