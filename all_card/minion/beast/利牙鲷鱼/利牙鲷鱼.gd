# 当你在战斗中有空位时，召唤两只3/1的食人鱼并使其立即攻击。

extends BaseCard
var 是否触发:bool=false

func 触发器_当在战斗中有空位时(player:Player):
	if 是否触发:
		return
	if player.is_fight():
		if player.fight:
			是否触发=true	
			for i in 2 if is_gold else 1:
				var 食人鱼=CardsUtils.find_card([
					CardFindCondition.build("name_str","食人鱼",CardFindCondition.ConditionEnum.等于)
				]).get(0).duplicate()
				食人鱼.atk=3
				食人鱼.hp=1
				player.add_card_in_bord(食人鱼)
				player.fight.mionion_do_attack(食人鱼,player,player.fight.get_敌人(player))
	pass
