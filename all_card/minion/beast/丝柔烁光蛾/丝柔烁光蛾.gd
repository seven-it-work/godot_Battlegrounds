#在本随从获得攻击力后，在本局对战中，你的甲虫拥有+2/+2。<b>亡语：</b>召唤一只{0}/{1}的甲虫。
extends BaseCard

func 触发器_获得攻击力(触发者:BaseCard,num:int,player:Player):
	super.触发器_获得攻击力(触发者,num,player)
	player.甲虫+=Vector2(2,2)*2 if is_gold else 1
	pass
