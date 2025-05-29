extends BeastCard

func get_AttributeBonus():
	return AttributeBonus.create("饥饿的钳嘴龟",0,0,"饥饿的钳嘴龟")

func 触发器_亡语触发监听(攻击者:BaseCard,死亡者:BaseCard,player:Player):
	if 死亡者.race.has(BaseCard.RaceEnum.BEAST):
		var f=func(find_card:BaseCard):
			find_card.add_hp(find_card,2 if self.is_gold else 1,player)
			pass
		player.minion_property_func(self,f,true)
	pass
