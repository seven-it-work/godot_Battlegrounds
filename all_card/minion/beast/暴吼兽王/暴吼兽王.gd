
extends BaseCard
#<b>嘲讽</b>。在本局对战中，你每召唤过一只野兽，便拥有+3/+2<i>（无论本随从在哪）</i>。

func 触发器_召唤(player:Player):
	super.触发器_召唤(player)
	add_atk(self,player.暴吼兽王加成*6 if is_gold else 3,player)
	add_hp(self,player.暴吼兽王加成*4 if is_gold else 2,player)
	pass

