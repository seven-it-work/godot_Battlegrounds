extends Control
class_name BaseCardUI

@onready var 背景图:=$"%背景图"

var cardData:CardEntity

static func build(cardData:CardEntity)->BaseCardUI:
	var temp=preload("uid://b631tye5dlbwf").instantiate()
	temp.cardData=cardData
	temp.add_child(cardData)
	return temp

var _是否初始:bool=false

func _process(delta: float) -> void:
	if cardData:
		if !_是否初始:
			_是否初始=true
			var 插画路径=cardData.get_插画路径()
			if FileAccess.file_exists(插画路径):
				背景图.texture=load(插画路径)
				pass
			else:
				if cardData.str_id:
					# 尝试下载
					var image_url="https://art.hearthstonejson.com/v1/orig/%s.png"%cardData.str_id
					print("尝试下载插画：",image_url)
					CardUtils.download_image(image_url,cardData.get_插画路径())
		
		$"SubViewportContainer/SubViewport/名称/Label".text=cardData.名称
		$"SubViewportContainer/SubViewport/等级/Label".text=str(cardData.等级)
		$"SubViewportContainer/SubViewport/金币".visible=cardData.卡片所在位置==Enums.CardPosition.酒馆
		$"SubViewportContainer/SubViewport/金币/Label".text=str(cardData.获取花费())
		$"SubViewportContainer/SubViewport/生命值".visible=false
		$"SubViewportContainer/SubViewport/攻击力".visible=false
		if cardData is BaseMinion:
			$"SubViewportContainer/SubViewport/生命值".visible=true
			$"SubViewportContainer/SubViewport/攻击力".visible=true
			%"圣盾".visible=cardData.获取圣盾()
			%"风怒".visible=cardData.获取风怒()
			%"潜行".visible=cardData.获取潜行()
			%"金色边框".visible=false
			%"普通边框".visible=false
			%"嘲讽边框".visible=false
			%"金色嘲讽边框".visible=false
			if cardData.获取嘲讽():
				if cardData.is_gold:
					%"金色嘲讽边框".visible=true
				else:
					%"嘲讽边框".visible=true
			else:
				if cardData.is_gold:
					%"金色边框".visible=true
				else:
					%"普通边框".visible=true
				
					
					
			
			#if !$"SubViewportContainer/SubViewport/背景图2/种族".visible:
				#ArrayUtils.unique_in_place(cardData.race)
				#ArrayUtils.unique_in_place(cardData.限定类型)
				#var temp_种族:String=""
				#$"SubViewportContainer/SubViewport/背景图2/种族".visible=true
				#for i in cardData.race:
					#if i==0:
						#continue
					#temp_种族+=Enums.CardRace.keys().get(i)+" "
				#$"SubViewportContainer/SubViewport/背景图2/种族".text=temp_种族
				
			var 属性=cardData.获取带加成属性()
			$"SubViewportContainer/SubViewport/攻击力/Label".text=str(属性.x)
			if cardData.player.是否在战斗中():
				$"SubViewportContainer/SubViewport/生命值/Label".text=str(cardData.current_hp)
			else:
				$"SubViewportContainer/SubViewport/生命值/Label".text=str(属性.y)
			#$"SubViewportContainer/SubViewport/背景图2/描述".text=str(cardData.获取描述())
		pass
	pass
