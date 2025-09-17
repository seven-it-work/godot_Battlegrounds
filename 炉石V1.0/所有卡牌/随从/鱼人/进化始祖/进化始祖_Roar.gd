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
	option1.script = preload("res://所有卡牌/随从/鱼人/进化始祖/进化始祖_Option1.gd")
	option1.lushi_id = 触发卡.lushi_id
	option1.str_id = 触发卡.str_id
	option1.名称 = "获得+3攻击力和圣盾"
	option1.描述 = "获得+3攻击力和<b>圣盾</b>。"
	option1.is_gold = 触发卡.is_gold
	抉择.chooseOption.append(option1)

	var option2 = BaseSpell.new()
	抉择.add_child(option2)
	option2.name = "Option2"
	option2.script = preload("res://所有卡牌/随从/鱼人/进化始祖/进化始祖_Option2.gd")
	option2.lushi_id = 触发卡.lushi_id
	option2.str_id = 触发卡.str_id
	option2.名称 = "获得+3生命值和烈毒"
	option2.描述 = "获得+3生命值和<b>烈毒</b>。"
	option2.is_gold = 触发卡.is_gold
	抉择.chooseOption.append(option2)

func _具体战吼方法接口():
	抉择.选择() # Present the choice to the player
