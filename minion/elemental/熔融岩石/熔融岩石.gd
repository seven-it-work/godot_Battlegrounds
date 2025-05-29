extends BaseCard

func 触发器_使用其他卡牌(使用的卡牌:BaseCard,player:Player,目标卡片:BaseCard):
	# 如果是不是元素
	if !使用的卡牌.race.has(BaseCard.RaceEnum.ELEMENTAL):
		return
	# 对自己属性修改
	for i in 2 if is_gold else 1:
		#（todo 这里有元素额外加成）
		self.add_hp(self,1,player)
	pass
