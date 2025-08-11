extends Node
class_name 元素工具类

static func 更新元素属性加成(player:Player,基础值:Vector2i):
	player.元素属性加成+=(player.元素加强加成+基础值)
	## 遍历酒馆 添加加成
	for i in player.酒馆:
		元素属性加成(i,player)

static func 元素属性加成(card:CardEntity,player:Player):
	if card is BaseMinion:
		if card.race.has(Enums.CardRace.元素):
			card.属性加成(AttributeBonus.build(
				"元素属性加成",
				player.元素属性加成,
				"元素属性加成"
			),true,player.是否在战斗中())
