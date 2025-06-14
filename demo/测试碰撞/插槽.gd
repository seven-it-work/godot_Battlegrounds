extends Control
class_name Slot 

var active := false

var tween:Tween

## 改变插槽大小
## value 插槽大小
## duration 动画时长
func change_size(value:Vector2, duration:float):
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "custom_minimum_size", value, duration)
	
