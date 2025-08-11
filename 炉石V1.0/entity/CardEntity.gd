extends Node
class_name CardEntity

@export var 卡牌类型:Enums.CardType=Enums.CardType.随从
@export var 卡片所在位置:Enums.CardPosition=Enums.CardPosition.无
@export var 抉择:Choose=null
@export var 选择目标对象:SelectTarget=null
@export var lushi_id:int=0
@export var str_id:String=""
@export var 名称:String=""
@export var 描述:String=""
@export var glod_描述:String=""
@export var 等级:int=1
@export var 花费:int=3
@export var is_gold:bool=false
@export var 是否出现在酒馆:bool=true

#region 持久化辅助对象
@export var 文件路径:String
@export var 文件名:String
## 卡牌所属的玩家
@export var player:Player
@export var 插画路径:String

func 获取倍率()->int:
	if is_gold:
		return 2
	return 1
	
func _to_string() -> String:
	return JSON.stringify(ObjectUtils.get_to_string(self))

func 信号绑定():
	pass

func 是否能够使用()->bool:
	return true

func 获取描述(dic:Dictionary={})->String:
	var tempDic=ObjectUtils.get_exported_properties(self)
	tempDic.merged(dic,true)
	return 描述.format(tempDic)

func 获取花费()->int:
	return 花费

func get_插画路径()->String:
	if 插画路径:
		return 插画路径
	if !文件路径:
		var temp= get_script().resource_path
		文件路径=temp.get_base_dir()
		文件名=temp.get_file().replace("."+temp.get_extension(),"")
	var 默认路径="%s/%s.png"%[文件路径,文件名]
	return 默认路径
