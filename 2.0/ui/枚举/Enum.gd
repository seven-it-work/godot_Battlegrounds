extends Node
class_name Enum
# 酒馆等级及其初始升级花费金币
const 酒馆等级及其初始升级花费金币={
	1:5,
	2:7,
	3:8,
	4:9,
	5:11
}
# 酒馆随从个数
const 酒馆随从个数={
	1:3,
	2:3,
	3:4,
	4:5,
	5:5,
	6:6
}
# 卡牌类型
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
	## 全部
	ALL,
}
