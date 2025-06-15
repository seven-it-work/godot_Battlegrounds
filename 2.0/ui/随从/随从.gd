extends Control
class_name Minion

@export var baseCard:BaseCard

func _ready() -> void:
	更新卡牌信息()
	pass


func 更新卡牌信息():
	if baseCard:
		if baseCard.show_name_str:
			$Node/名称/Label.text=baseCard.name_str if baseCard.name_str else baseCard.name;
			$Node/名称.show()
		if FileAccess.file_exists(baseCard.get_插画路径()):
			$Node/遮罩/TextureRect.texture=load(baseCard.get_插画路径())
			pass
		else:
			if baseCard.ls_card_id:
				# 尝试下载
				var image_url="https://art.hearthstonejson.com/v1/orig/%s.png"%baseCard.ls_card_id
				print("尝试下载插画：",image_url)
				CardsUtils.download_image(image_url,baseCard.get_插画路径())
		if baseCard.show_lv:
			if baseCard.lv==1:
				$"Node/等级/1级".show()
			elif baseCard.lv==2:
				$"Node/等级/2级".show()
			elif baseCard.lv==3:
				$"Node/等级/3级".show()
			elif baseCard.lv==4:
				$"Node/等级/4级".show()
			elif baseCard.lv==5:
				$"Node/等级/5级".show()
			elif baseCard.lv==6:
				$"Node/等级/6级".show()
			elif baseCard.lv==7:
				$"Node/等级/7级".show()
		
		if baseCard.show_atk:
			$Node/攻击力/Label.text="%s"%baseCard.atk_bonus(Globals.main_node.player);
			$Node/攻击力.show()
			pass
		if baseCard.show_hp:
			$Node/生命值/Label.text="%s"%baseCard.hp_bonus(Globals.main_node.player);
			$Node/生命值.show()
			pass
		if baseCard.show_buy_coins:
			$Node/金币/Label.text="%s"%baseCard.hp_bonus(Globals.main_node.player);
			$Node/金币.show()
			pass
		
		if baseCard.show_name_str:
			$"Node/名称/Label".text=baseCard.name_str
			$"Node/名称".show()
		
		$Node/嘲讽.hide()
		$Node/金色边框.hide()
		$Node/普通边框.hide()
		if baseCard.嘲讽:
			$Node/嘲讽.show()
		elif baseCard.is_gold:
			$Node/金色边框.show()
		else:
			$Node/普通边框.show()
		if baseCard.圣盾:
			$Node/圣盾.show()
		else:
			$Node/圣盾.hide()
		if baseCard.冻结:
			$Node/冻结.show()
		else:
			$Node/冻结.hide()
		if baseCard.风怒 or  baseCard.超级风怒:
			$Node/遮罩/风怒.show()
		else:
			$Node/遮罩/风怒.hide()
		if baseCard.潜行:
			$Node/遮罩/潜行.show()
		else:
			$Node/遮罩/潜行.hide()
		$Node/剧毒.hide()
		$Node/烈毒.hide()
		$Node/触发.hide()
		$Node/亡语.hide()
		if baseCard.剧毒:
			$Node/剧毒.show()
		elif baseCard.烈毒:
			$Node/烈毒.show()
		elif baseCard.触发:
			$Node/触发.show()
		elif baseCard.是否存在亡语():
			$Node/亡语.show()
		print("初始化")
	pass
