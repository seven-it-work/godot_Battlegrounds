extends Node
class_name BasePeople

@export var name_str:String=""
@export var 头像file:String=""
@export var lv:int=1;

@export var hp_max:float=100;
@export var hp_current:float=100;

@export var hd_max:float=100;
@export var hd_current:float=0;

@export var atk_min:float=10;
@export var atk_max:float=20;

@export var def_min:float=5;
@export var def_max:float=10;

@export var lingLi_max:float=100;
@export var lingLi_current:float=100;

@export var exp_max:float=100;
@export var exp_current:float=0;

@export var 吸收灵力冷却时间:float=200;
@export var 吸收灵力单位量:float=5;

@export var 打坐冷却时间:float=200;
@export var 打坐单位量:float=5;
@export var 打坐消耗灵力量:float=100;

@export var 修炼冷却时间:float=300;
@export var 修炼单位量:float=5;
@export var 修炼消耗灵力量:float=100;

@export var 集气速度_min:float=1;
@export var 集气速度_max:float=2;

func 获取集气速度()->float:
	return randf_range(集气速度_min,集气速度_max)

func 吸收灵力(lingLi:float):
	var value=吸收灵力单位量
	if lingLi<value:
		value=lingLi
	lingLi_current=minf(lingLi_current+value,lingLi_max)

func 打坐恢复():
	var 恢复值=打坐单位量
	if lingLi_current<打坐消耗灵力量:
		恢复值=lingLi_current*(打坐单位量/打坐消耗灵力量)
		lingLi_current=0
	else:
		lingLi_current-=打坐消耗灵力量
	hp_current=minf(hp_current+恢复值,hp_max)

func 修炼():
	var 经验值=修炼单位量
	if lingLi_current<修炼消耗灵力量:
		经验值=lingLi_current*(修炼单位量/修炼消耗灵力量)
		lingLi_current=0
	else:
		lingLi_current-=修炼消耗灵力量
	exp_current=minf(exp_current+经验值,exp_max)

func 升级():
	exp_current=0;
	lv+=1;
	pass
