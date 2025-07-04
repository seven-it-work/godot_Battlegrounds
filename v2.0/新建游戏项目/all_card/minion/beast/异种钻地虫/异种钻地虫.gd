extends CardData

var temp_atk=1;
var temp_hp=1;

func 触发器_复仇(player:Player):
	temp_atk+=1*获取是否为金色的倍率()
	temp_hp+=1*获取是否为金色的倍率()
	var list=player.战场.获取所有节点().filter(func(card:DragControl): return card.card_data.uuid==uuid)
	if list.is_empty():
		return
	for i in list:
		print("给原有的属性同样赋值")
		i.card_data.temp_atk+=1*获取是否为金色的倍率()
		i.card_data.temp_hp+=1*获取是否为金色的倍率()
