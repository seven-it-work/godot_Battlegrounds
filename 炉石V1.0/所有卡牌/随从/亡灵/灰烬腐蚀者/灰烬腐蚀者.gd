extends BaseMinion

func 信号绑定():
	player.英雄受伤信号.connect(_on_英雄受伤)

func _on_英雄受伤(伤害值: int):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return

	# Deal damage back to the attacker (assuming the attacker is the enemy hero)
	# This is a placeholder - the actual implementation would need to identify the attacker
	# and deal damage back to them
	
	# Increase Tavern Spell attack bonus
	var buff_value: int = 1
	if is_gold:
		buff_value = 2
	player.酒馆法术攻击力加成 += buff_value
