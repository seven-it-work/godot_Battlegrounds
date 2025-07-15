extends Node
class_name Item
enum ItemRank{
凡品,
良品,
上品,
极品,
秘宝,
灵宝,
古宝,
}

@export var item_name:String=""
@export var texture_path:String=""
@export var item_rank:ItemRank=ItemRank.凡品
@export_range(1,9) var item_rank_lv:int=1

func 获取品阶名称()->String:
	var map:Dictionary={
		ItemRank.凡品:"凡品",
		ItemRank.良品:"良品",
		ItemRank.上品:"上品",
		ItemRank.极品:"极品",
		ItemRank.秘宝:"秘宝",
		ItemRank.灵宝:"灵宝",
		ItemRank.古宝:"古宝",
	}
	return map[item_rank]+"(%s阶)"%item_rank_lv

func 获取品阶对应颜色()->Color:
	var 颜色map:Dictionary={
		ItemRank.凡品: ['#CCCCCC','#605858'],
		ItemRank.良品: ['#222A35','#006BFF'],
		ItemRank.上品: ['#00A6A9','#95FDFF'],
		ItemRank.极品: ['#804DC8','#3A008B'],
		ItemRank.秘宝: ['#C5C660','#FDFF00'],
		ItemRank.灵宝: ['#F28234','#823600'],
		ItemRank.古宝: ['#C65043','#7B0C00'],
	}
	var hex16=颜色map.get(item_rank)
	var 开始颜色:Color=Color(hex16[0])
	var 结束颜色:Color=Color(hex16[1])
	var list=ColorUtils.generate_color_gradient(开始颜色,结束颜色,9)
	return list.get(item_rank_lv-1);
