extends BaseCard

var chu_shou_atk:int=8;
var chu_shou_hp:int=8;

func add_card_in_bord_end(player:Player):
	player.summoned.connect(_summoned)
	pass

func _summoned(summoned_card:BaseCard,player:Player):
	if player.is_fight:
		var call_func = func (findCard:BaseCard):
			findCard.chu_shou_atk+=2
			findCard.chu_shou_hp+=2
		player.minion_property_func(self,call_func,true)
	pass
