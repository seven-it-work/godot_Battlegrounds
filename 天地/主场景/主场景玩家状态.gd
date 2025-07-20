extends HBoxContainer

@export var player:BasePeople

func _process(delta: float) -> void:
	if player:
		$"属性对1/血量".max_value=(player.hp_max)
		$"属性对1/血量".value=str(player.hp_current)
		
		$"属性对1/护盾".max_value=(player.hd_max)
		$"属性对1/护盾".value=str(player.hd_current)
		
		$"属性对2/灵力".max_value=(player.lingLi_max)
		$"属性对2/灵力".value=str(player.lingLi_current)
		
		$"属性对2/经验".max_value=(player.exp_max)
		$"属性对2/经验".value=str(player.exp_current)
		
		$"属性对3/攻击".max_value=(player.atk_max)
		$"属性对3/攻击".min_value=(player.atk_min)
		
		$"属性对3/防御".max_value=(player.def_max)
		$"属性对3/防御".min_value=(player.def_min)
		
		$"头像".player=player
		pass
