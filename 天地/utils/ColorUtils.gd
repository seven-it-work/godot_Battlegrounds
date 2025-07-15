@tool
extends Node
class_name ColorUtils

## 从start_color到end_color进行steps次渐变
static func generate_color_gradient(start_color: Color, end_color: Color, steps: int) -> Array[Color]:
	var gradient_colors: Array[Color] = []
	var start_red = start_color.r
	var start_green = start_color.g
	var start_blue = start_color.b
	var start_alpha = start_color.a
	var end_red = end_color.r
	var end_green = end_color.g
	var end_blue = end_color.b
	var end_alpha = end_color.a
	var red_step = (end_red - start_red) / steps
	var green_step = (end_green - start_green) / steps
	var blue_step = (end_blue - start_blue) / steps
	var alpha_step = (end_alpha - start_alpha) / steps
	for i in steps:
		var red = start_red + red_step * i
		var green = start_green + green_step * i
		var blue = start_blue + blue_step * i
		var alpha = start_alpha + alpha_step * i
		gradient_colors.append(Color(red, green, blue, alpha))
	return gradient_colors
