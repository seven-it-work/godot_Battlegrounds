extends Node
class_name Enums

enum CardTypeEnum{
	MINION,
	## 饰品
	TRINKEt,
	## 法术
	SPELL,
	## 酒馆法术
	TAVERN,
	HERO,
	HERO_POWER
}

enum CardPosition{
	酒馆,
	手牌,
	战场,
	NONE,
}

#随从种类
enum RaceEnum{
	## 没有类型
	NONE,
	## 野兽
	BEAST,
	## 恶魔
	DEMON,
	## 龙
	DRAGON,
	## 元素
	ELEMENTAL,
	## 机械
	MECH,
	## 鱼人
	MURLOC,
	## 纳迦
	NAGA,
	## 海盗
	PIRATE,
	## 野猪
	QUILBOAR,
	## 亡灵
	UNDEAD,
}
