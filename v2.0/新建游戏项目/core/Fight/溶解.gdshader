shader_type canvas_item;
uniform float dissolve_amount : hint_range(0, 1);

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    if (color.a * (1.0 - dissolve_amount) < 0.01) {
        discard;
    }
    COLOR = color;
}