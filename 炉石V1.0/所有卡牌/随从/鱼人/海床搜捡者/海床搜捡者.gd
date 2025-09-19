extends BaseMinion

@export var DuoGameExclusive:bool = true

func 信号绑定():
	player.回合结束信号.connect(_on_回合结束)

func _on_回合结束():
	if 卡片所在位置 != Enums.CardPosition.战场:
		return
	_trigger_team_keyword_buff()

func _trigger_team_keyword_buff():
	# Assuming player.队友 exists and has a method to get team's keyword count
	# For now, we'll simulate by checking different keywords and applying buffs
	var team_keywords: Array[String] = ['圣盾', '嘲讽', '复生', '剧毒', '烈毒', '风怒', '潜行']
	var keyword_count: int = 0
	# Placeholder for counting team's keywords
	# This would involve checking all minions on both players' boards for keywords
	# For now, we'll simulate with a random count
	keyword_count = randi() % 4 # Random count for simulation

	var buff_value: int = keyword_count
	if is_gold:
		buff_value *= 2 # Golden version doubles the buff

	var 加成 = AttributeBonus.build(
		'海床搜捡者加成',
		Vector2i(buff_value, buff_value),
		str(lushi_id)
	)
	属性加成(加成, true) # Permanent buff
	print("海床搜捡者触发：根据队伍关键词数量 %d 获得属性加成" % keyword_count)
