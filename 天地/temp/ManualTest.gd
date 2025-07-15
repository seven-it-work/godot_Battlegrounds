extends Control

const DestinationScene = preload("uid://ip2nmb50scen")

func _on_instant_button_pressed():
	Transitions.change_scene_to_instance(DestinationScene.instantiate(), Transitions.FadeType.Instant)
	
func _on_cross_fade_button_pressed():
	Transitions.change_scene_to_instance(DestinationScene.instantiate(), Transitions.FadeType.CrossFade)

func _on_blend_button_pressed():
	FancyFade.blurry_noise(DestinationScene.instantiate())
