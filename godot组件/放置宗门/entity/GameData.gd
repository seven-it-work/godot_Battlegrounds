extends Node
class_name GameData
@export_range(1,100) var 时间倍速:int=1
## 1s 60帧=60次process运行
@export var game_times:int=0
## 10s=60*10次=1天
@export var game_time_days:int=1
## 30天=1月
@export var game_time_month:int=1
## 12月=1年
@export var game_time_year:int=1
## 1000年=1纪
@export var game_time_eon:int=1
## 1000纪=1纪元
@export var game_time_cosmic:int=1

func add_time():
	game_times+=1
	if game_times>=60*10/时间倍速:
		game_times=0;
		game_time_days+=1
	if game_time_days>=30:
		game_time_days=1;
		game_time_month+=1;
	if game_time_month>=12:
		game_time_month=1;
		game_time_year+=1
	if game_time_year>=1000:
		game_time_year=1;
		game_time_eon+=1
	if game_time_eon>=1000:
		game_time_eon=1;
		game_time_cosmic+=1

func 获取时间Str()->String:
	return "%s纪元%s纪%s年%s月%s日"%[
		game_time_cosmic,
		game_time_eon,
		game_time_year,
		game_time_month,
		game_time_days,
	]
