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


func _on_button_pressed() -> void:
	var f=func(target:CardUi=null):
		player.user_card(card.card,target.card if target else null)
		Globals.main_node.提示信息修改(null)
	# 如果card需要选择对象
	if card.card.need_select_target:
		Globals.main_node.选择的继续运行方法=f
		Globals.main_node.选择的cardUi=card
		Globals.main_node.提示信息修改(null)
		card.disable=true
		return
	f.call()
	
	pass # Replace with function body.
