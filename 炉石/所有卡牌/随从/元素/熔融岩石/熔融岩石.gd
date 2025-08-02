extends BaseMinionCard

func 信号绑定方法():
	player.使用卡牌信号.connect(func(使用的卡片:LuShiCard):
		if self.卡片所在位置==Enums.CardPosition.战场:
			if self!=使用的卡片:
				if 使用的卡片 is BaseMinionCard:
					if 使用的卡片.是否属于该种族(Enums.CardRace.元素):
						添加加成属性(AttributeBonus.build(名称,player.元素加成+Vector2(0,1*获取属性倍率()),""),true)
	)
	pass
