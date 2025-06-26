extends ChooseOption

var base_atk=2;
var base_hp=2;

func get_desc(player:Player,otherJson:Dictionary={})->String:
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	otherJson.set("法术攻击值",base_atk+合计加成.atk)
	otherJson.set("法术生命值",base_hp+合计加成.hp)
	return super.get_desc(player,otherJson)

func 执行方法(player:Player,card:DragControl):
	player.时间管理执行次数+=1
