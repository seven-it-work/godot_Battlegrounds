extends BaseCard

func 触发器_使用其他卡牌(使用的卡牌:BaseCard,player:Player,目标卡片:BaseCard):
	# 如果是不是元素
	if !使用的卡牌.race.has(BaseCard.RaceEnum.ELEMENTAL):
		return
	# 对自己属性修改
	for i in 2 if is_gold else 1:
		self.add_atk(self,player.元素加成.x,player)
		self.add_hp(self,player.元素加成.y+1,player)
	pass
