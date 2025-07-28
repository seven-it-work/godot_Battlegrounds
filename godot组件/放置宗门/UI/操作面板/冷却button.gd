extends Button

@export_enum("从左到右","从右到左","从上到下","从下到上") var 冷却方向:String="从右到左"
@export var 冷却计数器:int=0
@export var 冷却时间:int=0

func _process(delta: float) -> void: 
	if 冷却时间>0:
		var step=self.size/冷却时间
		disabled=冷却计数器!=0
		if 冷却计数器<=0:
			$Panel.size=Vector2(0,0)
		else:
			if 冷却方向=="从右到左":
				$Panel.size.y=size.y
				$Panel.size.x=冷却计数器*step.x
			if 冷却方向=="从左到右":
				$Panel.size.y=size.y
				$Panel.size.x=冷却计数器*step.x
				$Panel.position.x=size.x-$Panel.size.x
			if 冷却方向=="从上到下":
				$Panel.size.x=size.x
				$Panel.size.y=冷却计数器*step.y
				$Panel.position.y=size.y-$Panel.size.y
			if 冷却方向=="从下到上":
				$Panel.size.x=size.x
				$Panel.size.y=冷却计数器*step.y
	pass
