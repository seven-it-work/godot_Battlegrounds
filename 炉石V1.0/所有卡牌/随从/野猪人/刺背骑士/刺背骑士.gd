extends BaseMinion

@export var 风怒:bool = true
@export var 圣盾:bool = true
var _damage_taken_count: int = 0
var _max_damage_taken: int = 1

func _ready():
	if is_gold:
		_max_damage_taken = 2 # Golden version can take damage twice

func 信号绑定():
	player.随从受伤信号.connect(_on_随从受伤)

func _on_随从受伤(受伤随从: BaseMinion, 伤害值: int):
	if 受伤随从 == self and 卡片所在位置 == Enums.CardPosition.战场:
		_damage_taken_count += 1
		if _damage_taken_count <= _max_damage_taken:
			# Gain Divine Shield after taking damage and surviving
			圣盾 = true
			print("刺背骑士触发：受伤后获得圣盾")
