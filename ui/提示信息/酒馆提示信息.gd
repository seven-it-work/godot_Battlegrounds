extends VBoxContainer

var card:CardUi
var player:Player

func initData(card:CardUi):
	self.card=card
	$RichTextLabel.text=card.card.get_desc()
	$GridContainer/lv.text="等级：%s"%card.card.lv
	$GridContainer/atk.text="攻击：%s"%card.card.atk_bonus()
	$GridContainer/hp.text="生命：%s"%card.card.hp_bonus()
	pass

func _process(delta: float) -> void:
	if Globals and Globals.main_node and Globals.main_node.选择的cardUi:
		$"选中".show()
		$GridContainer/Button.hide()
	else:
		if $"选中".visible:
			$"选中".visible=false
			$GridContainer/Button.show()

func _on_button_pressed() -> void:
	player.buy_card(card.card)
	Globals.main_node.提示信息修改(null)
	pass # Replace with function body.
