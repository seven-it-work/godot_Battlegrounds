extends VBoxContainer

var card:CardUi
var player:Player

func initData(card:CardUi):
	self.card=card
	$RichTextLabel.text=card.card.get_desc(Globals.main_node.player)
	$GridContainer/lv.text="等级：%s"%card.card.lv
	$GridContainer/atk.text="攻击：%s"%card.card.atk_bonus(player)
	$GridContainer/hp.text="生命：%s"%card.card.hp_bonus(player)
	pass


func _on_button_pressed() -> void:
	player.sell_card(card.card)
	Globals.main_node.提示信息修改(null)
	pass # Replace with function body.
