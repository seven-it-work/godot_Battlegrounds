extends Camera2D
func _process(delta: float) -> void:
	if Input.is_action_pressed("w"):
		self.position.y-=1
	if Input.is_action_pressed("s"):
		self.position.y+=1
	if Input.is_action_pressed("a"):
		self.position.x-=1
	if Input.is_action_pressed("d"):
		self.position.x+=1

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("碰撞了1")
	SceneManager.change_scene("uid://ca3lhe4kkolhq", {
		"on_tree_enter": _战斗信息初始化
	})
	pass # Replace with function body.

func _战斗信息初始化(scene):
	print("wow I just entered the tree!")
