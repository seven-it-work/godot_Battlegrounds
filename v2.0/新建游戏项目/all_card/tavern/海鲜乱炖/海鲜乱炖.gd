extends CardData
var base_atk=1;
var base_hp=1;

func get_desc(otherJson:Dictionary={})->String:
	var 合计加成=AttributeBonus.计算总和(player.法术加成)
	otherJson.set("法术攻击值",base_atk+合计加成.atk)
	otherJson.set("法术生命值",base_hp+合计加成.hp)
	return super.get_desc(player,otherJson)
	
func 使用触发():
	super.使用触发(player)
	if $"使用时是否需要选择目标".目标对象:
		# 如果目标存在类型
		var cardData= $"使用时是否需要选择目标".目标对象.card_data as CardData
		var 合计加成=AttributeBonus.计算总和(player.法术加成)
		# 执行次数
		var 次数=1;
		for i in player.战场.获取所有节点():
			var temp=i.card_data as CardData
			次数+=temp.获取额外属性个数()
		for i in 次数:
			var attri=get_AttributeBonus()
			attri.atk=base_atk+合计加成.atk
			attri.hp=base_hp+合计加成.hp
			cardData.属性添加(self,attri)
