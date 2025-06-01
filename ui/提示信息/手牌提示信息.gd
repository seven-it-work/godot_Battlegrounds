extends VBoxContainer

var card:BaseCard
var player:Player

func initData(card:BaseCard):
	self.card=card
	$RichTextLabel.text=card.get_desc()
	$GridContainer/lv.text="等级：%s"%card.lv
	$GridContainer/atk.text="攻击：%s"%card.atk_bonus()
	$GridContainer/hp.text="生命：%s"%card.hp_bonus()
	pass


func _on_button_pressed() -> void:
	player.user_card(card)
	Globals.main_node.提示信息修改(null)
	pass # Replace with function body.
