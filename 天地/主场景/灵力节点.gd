extends BaseMainNode
class_name LingLiMainNode
@export var 当前灵力值:float=0;
@export var player:BasePeople

func 取消():
	if $"节点额外操作/吸收":
		$"节点额外操作/吸收".是否自动点击.button_pressed=false

func _on_吸收_按钮点击() -> void:
	if player:
		var value=player.吸收灵力单位量
		if 当前灵力值<value:
			value=当前灵力值
		当前灵力值-=value
		player.吸收灵力(当前灵力值)
	pass # Replace with function body.
