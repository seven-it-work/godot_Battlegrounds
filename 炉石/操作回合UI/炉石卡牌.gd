extends DragObj
class_name LuShiCard

@export var 卡牌类型:Enums.CardType=Enums.CardType.随从
@export var 卡片所在位置:Enums.CardPosition=Enums.CardPosition.无
@export var 抉择:Choose
@export var 选择目标对象:SelectTarget
@export var lushi_id:int=0
@export var str_id:String=""
@export var 名称:String=""
@export var 描述:String=""
@export var 等级:int=0
@export var 花费:int=0

## 子类自己去实现（会在 添加卡片 这个方法去调用）
func 信号绑定方法(player:Player):
	pass

func 是否能够使用()->bool:
	return true

func 获取描述(dic:Dictionary={})->String:
	var tempDic=ObjectUtils.get_exported_properties(self)
	tempDic.merged(dic,true)
	return 描述.format(tempDic)

func _process(delta: float) -> void:
	super._process(delta)
	if PlayerOperationUI.操作回合:
		if get_global_rect().has_point(get_global_mouse_position()):
			#print("更新Tips:",name)
			# 调用更新Tips方法
			pass

func 待选择样式():
	var style=$PanelContainer.get_theme_stylebox("panel") as StyleBoxFlat
	style.border_color=Color(0.0, 0.954, 0.502)
	$PanelContainer.add_theme_stylebox_override("panel",style)
	pass

func 选中样式():
	var style=$PanelContainer.get_theme_stylebox("panel") as StyleBoxFlat
	style.border_color=Color(0.948, 0.786, 0.0)
	$PanelContainer.add_theme_stylebox_override("panel",style)
	pass
	
func 原始样式():
	var style=$PanelContainer.get_theme_stylebox("panel") as StyleBoxFlat
	style.border_color=Color(0.8, 0.8, 0.8)
	$PanelContainer.add_theme_stylebox_override("panel",style)
	pass
