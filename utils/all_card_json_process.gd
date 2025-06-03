# 卡片json转换文件处理工具
extends Control
var version

func _ready() -> void:
	main()

func main():
	var all_json=FileAccess.open("res://资料/32.2.4.221850/get_full_cards.json",FileAccess.READ)
	var json_str=all_json.get_as_text()
	var error=FileAccess.get_open_error()
	var obj=json_str_2_obj(json_str).data
	print("准备写入版本",obj.version)
	version=obj.version
	print("准备写入minion")
	for i in obj.minion:
		write_jsont_obj(i)
	print("minion写入完成")
	pass

func write_jsont_obj(obj:Dictionary):
	# 如果存在tokens
	if obj.has("tokens"):
		for i in obj.tokens:
			write_jsont_obj(i)
	var tscn_save_path=""
	var gd_save_path=""
	if obj.cardType=="spell":
		tscn_save_path="res://all_card/%s/%s/%s.tscn"%[obj.cardType,obj.nameCN,obj.nameCN]
		gd_save_path="res://all_card/%s/%s/%s.gd"%[obj.cardType,obj.nameCN,obj.nameCN]
	elif obj.cardType=="minion":
		tscn_save_path="res://all_card/%s/%s/%s/%s.tscn"%[obj.cardType,obj.minionTypes[0],obj.nameCN,obj.nameCN]
		gd_save_path="res://all_card/%s/%s/%s/%s.gd"%[obj.cardType,obj.minionTypes[0],obj.nameCN,obj.nameCN]
		if !obj.has("minionTypes") or !obj.minionTypes:
			print("写入错误，这个东西不存在")
			return
	else:
		print("暂时不支持")
		return
	if FileAccess.file_exists(tscn_save_path):
		print("tscn存在了",obj.nameCN)
		return
	if FileAccess.file_exists(gd_save_path):
		print("gd存在了",obj.nameCN)
		return
	DirAccess.make_dir_absolute(gd_save_path.get_base_dir())
	var gd_file_text=obj_2_gd_file_text(obj)
	var gd_file=FileAccess.open(gd_save_path,FileAccess.WRITE)
	gd_file.store_string(gd_file_text)
	print("写入gd成功",obj.nameCN)
	
	DirAccess.make_dir_absolute(gd_save_path.get_base_dir())
	var tscn_text=obj_2_file_text(obj,gd_save_path)
	var tscn_file=FileAccess.open(tscn_save_path,FileAccess.WRITE)
	tscn_file.store_string(tscn_text)
	print("写入tscn成功",obj.nameCN)

func obj_2_gd_file_text(obj:Dictionary):
	var text="""
extends BaseCard
# todo 去继承BaseCard相关方法
	"""
	return text

func obj_2_file_text(obj:Dictionary,script_path:String):
	var race_list=[]
	if obj.cardType=="minion":
		for i in obj.minionTypes:
			race_list.append(BaseCard.RaceEnum[i.to_upper()])
	var cardType=BaseCard.CardTypeEnum[obj.cardType.to_upper()]
	var text_format_dic={
		strId=obj.strId,
		nameCN=obj.nameCN,
		tier=obj.tier if obj.has("tier") else 0,
		attack=obj.attack if obj.has("attack") else 0,
		health=obj.health if obj.has("health") else 0,
		text=obj.text,
		gold_desc=obj.upgradeCard.text if obj.has("upgradeCard") else obj.text,
		race=race_list,
		script_path=script_path,
		cardType=cardType,
		version=version,
	}
	var baseText="""
[gd_scene load_steps=2 format=3]
[ext_resource type="Script"  path="{script_path}" id="1_cc03i"]
[node name="{nameCN}" type="Node2D"]
script = ExtResource("1_cc03i")
version="{version}"
ls_card_id="{strId}"
name_str = "{nameCN}"
cardType = {cardType}
lv = {tier}
atk = {attack}
hp = {health}
desc = "{text}"
gold_desc = "{gold_desc}"
race = Array[int]({race})
	"""
	return baseText.format(text_format_dic)

func json_str_2_obj(json:String)->Dictionary:
	return JSON.parse_string(json)
