extends Node2D
class_name BaseCard

var uuid:String=""
@export var name_str:String=""
# 等级
@export var lv:int=1
## 攻击力
@export var atk:int=0;
## 生命值
@export var hp:int=1;
# 属性
@export var 嘲讽:bool=false
@export var 圣盾:bool=false
@export var 复生:bool=false
@export var 剧毒:bool=false
@export var 风怒:bool=false
# 特殊属性
@export var 超级风怒:bool=false
@export var 烈毒:bool=false
@export var 是否为伙伴:bool=false
@export var 是否出现在酒馆:bool=true

## 是否使用时是否需要选中目标
@export var need_select_target:bool=false

@export var 亡语:Array[Dead]=[]
@export var 战吼:Array[Roar]=[]

func _init() -> void:
	self.uuid=UUID.v4()

# 随从死亡时
func dead(player:Player):
	# 移除自己
	player.remove_card(self)
	for i in 亡语:
		i.do_action(self,player)
	pass
	
## add_card_in_bord执行完后调用
func add_card_in_bord_end(player:Player):
	pass


func uuid_eq(other:BaseCard)->bool:
	return other.uuid==self.uuid
