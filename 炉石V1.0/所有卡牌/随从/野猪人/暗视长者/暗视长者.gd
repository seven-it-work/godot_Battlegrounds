extends BaseMinion

@export var _gold_spent_counter: int = 0
@export var _gold_spent_threshold: int = 6

func 信号绑定():
	player.本回合花费金币信号.connect(_on_本回合花费金币)

func _on_本回合花费金币(amount: int):
	if 卡片所在位置 != Enums.CardPosition.战场:
		return

	_gold_spent_counter += amount
	while _gold_spent_counter >= _gold_spent_threshold:
		_gold_spent_counter -= _gold_spent_threshold
		_trigger_blood_gem_buff()

func _trigger_blood_gem_buff():
	var blood_gems_per_quilboar: int = 1
	if is_gold:
		blood_gems_per_quilboar = 2 # Golden version gives 2 blood gems per quilboar

	var quilboars: Array = player.获取战场上的牌().filter(func(m): 
		return (Enums.CardRace.野猪人 in (m as BaseMinion).race)
	)
	
	for quilboar in quilboars:
		for i in blood_gems_per_quilboar:
			var blood_gem = CardUtils.get_card('鲜血宝石', player)
			if blood_gem:
				# Use the blood gem on the quilboar
				(quilboar as BaseMinion).属性加成(AttributeBonus.build('鲜血宝石', Vector2i(1, 1), str(lushi_id)), true)
				print("暗视长者触发：给野猪人鲜血宝石")
