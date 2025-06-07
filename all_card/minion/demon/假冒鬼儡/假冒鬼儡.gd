
extends BaseCard
#在你的回合结束时，吞食酒馆中的一个随从以获得其双倍属性值。
func 触发器_回合结束时(player:Player):
	super.触发器_回合结束时(player)
	var tempCard:BaseCard=player.tavern.get_all_minion().pick_random()
	if tempCard:
		self.add_atk(self,tempCard.atk_bonus(player)*2 if is_gold else 1,player)
		self.add_hp(self,tempCard.hp_bonus(player)*2 if is_gold else 1,player)
	pass
