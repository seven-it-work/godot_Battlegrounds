extends Camera2D
@export var player:BasePeople

func _process(delta: float) -> void:
	if player:
		$Label.text=player.name_str.substr(0,1)
	if Input.is_action_pressed("w"):
		self.position.y-=1
	if Input.is_action_pressed("s"):
		self.position.y+=1
	if Input.is_action_pressed("a"):
		self.position.x-=1
	if Input.is_action_pressed("d"):
		self.position.x+=1

func _on_area_2d_area_entered(area: Area2D) -> void:
	var fight:Fight=preload("uid://ca3lhe4kkolhq").instantiate()
	player.reparent(fight)
	var target=area.get_parent().people as BasePeople
	target.reparent(fight)
	FancyFade.blurry_noise(fight)
	var listP:Array[BasePeople]=[player as BasePeople]
	var listE:Array[BasePeople]=[target as BasePeople]
	fight.开始战斗(listP,listE)
	pass # Replace with function body.
