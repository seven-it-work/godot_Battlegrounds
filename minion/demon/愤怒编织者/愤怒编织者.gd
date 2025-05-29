extends BaseCard

func 触发器_使用其他卡牌(使用的卡牌:BaseCard,player:Player,目标卡片:BaseCard):
	# 如果是不是恶魔 退出
	if !使用的卡牌.race.has(BaseCard.RaceEnum.DEMON):
		return
	# 对玩家造成伤害
	player.player_hp_add(-1)
	# 对自己属性修改
	self.add_atk(self,4 if is_gold else 2,player)
	self.add_hp(self,2 if is_gold else 1,player)
	pass
