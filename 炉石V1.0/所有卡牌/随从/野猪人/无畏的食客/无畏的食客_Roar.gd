extends Roar

@export var 抉择:Choose

func _ready():
	# Setup Choose node and options
	抉择 = Choose.new()
	触发卡.add_child(抉择)
	抉择.name = "Choose"
	抉择.chooseOption = []

	var option1 = BaseSpell.new()
	抉择.add_child(option1)
	option1.name = "Option1"
	option1.script = preload("res://所有卡牌/随从/野猪人/无畏的食客/无畏的食客_Option1.gd")
	option1.lushi_id = 触发卡.lushi_id
	option1.str_id = 触发卡.str_id
	option1.名称 = "增强鲜血宝石"
	option1.描述 = "在本局对战中，你的鲜血宝石使随从额外获得+1/+1"
	option1.is_gold = 触发卡.is_gold
	抉择.chooseOption.append(option1)

	var option2 = BaseSpell.new()
	抉择.add_child(option2)
	option2.name = "Option2"
	option2.script = preload("res://所有卡牌/随从/野猪人/无畏的食客/无畏的食客_Option2.gd")
	option2.lushi_id = 触发卡.lushi_id
	option2.str_id = 触发卡.str_id
	option2.名称 = "获取鲜血宝石"
	option2.描述 = "获取4张鲜血宝石"
	option2.is_gold = 触发卡.is_gold
	抉择.chooseOption.append(option2)

func _具体战吼方法接口():
	# The Choose node will handle the selection
	pass
