extends MarginContainer
@export var player:BasePeople

func _process(delta: float) -> void:
	if player:
		if StrUtils.is_blank(player.头像file):
			$Label.text=player.name_str
		else:
			$TextureRect.texture=load(player.头像file)
