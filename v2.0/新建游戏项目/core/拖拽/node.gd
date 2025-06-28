extends Control

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	# 1. 创建ShaderMaterial并设置基础参数
	var material = ShaderMaterial.new()
	material.shader = preload("uid://1a5gj0smhewv")  # 加载你的溶解Shader
	material.set_shader_parameter("dissolve_amount", 0.0)  # 初始未溶解
	material = material
	var tween = create_tween()
	tween.tween_property(material, "shader_parameter/dissolve_amount", 1.0, 2.0)
