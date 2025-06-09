
extends BaseCard
func 触发器_获得生命值(触发者:BaseCard,num:int,player:Player):
	super.触发器_获得生命值(触发者,num,player)
	pass
	
func 触发器_获得攻击力(触发者:BaseCard,num:int,player:Player):
	super.触发器_获得攻击力(触发者,num,player)
	pass
	
func 触发器_他人获得攻击力(获得者:BaseCard,num:int,player:Player):
	super.触发器_他人获得攻击力(获得者,num,player)
	pass

func 手牌触发器_战斗开始时(player:Player):
	super.手牌触发器_战斗开始时(player)
	pass

func 触发器_回合结束时(player:Player):
	super.触发器_回合结束时(player)
	pass

func 触发器_回合开始时(player:Player):
	super.触发器_回合开始时(player)
	pass

func 触发器_出售(player:Player):
	super.触发器_出售(player)
	pass

func 触发器_玩家受伤(palyer:Player,num:int)->int:
	num=super.触发器_玩家受伤(palyer,num)
	return num

func 触发器_使用其他卡牌(使用的卡牌:BaseCard,player:Player,目标卡片:BaseCard):
	super.触发器_使用其他卡牌(使用的卡牌,player,目标卡片)
	pass

func 触发器_使用(player:Player,目标卡片:BaseCard):
	super.触发器_使用(player,目标卡片)
	pass

func 触发器_亡语触发监听(攻击者:BaseCard,死亡者:BaseCard,player:Player):
	super.触发器_亡语触发监听(攻击者,死亡者,player)
	pass

func 触发器_亡语(attaker:BaseCard,player:Player):
	super.触发器_亡语(attaker,player)
	pass

func 触发器_战吼触发监听(触发者:BaseCard,player:Player):
	super.触发器_战吼触发监听(触发者,player)
	pass

func 触发器_战吼(player:Player,targetCard:BaseCard=null):
	super.触发器_战吼(player,targetCard)
	pass

func 触发器_召唤他人(召唤card:BaseCard,player:Player):
	super.触发器_召唤他人(召唤card,player)
	pass

func 触发器_召唤(player:Player):
	super.触发器_召唤(player)
	pass

func 触发器_他人受伤(atkker:BaseCard,injurie_card:BaseCard,num:int,player:Player):
	super.触发器_他人受伤(atkker,injurie_card,num,player)
	pass

func 触发器_受伤(atkker:BaseCard,num:int,player:Player):
	super.触发器_受伤(atkker,num,player)
	pass

func 触发器_战斗开始时(player:Player):
	super.触发器_战斗开始时(player)
	pass

func 触发器_战斗结束后(player:Player):
	super.触发器_战斗结束后(player)
	pass
	