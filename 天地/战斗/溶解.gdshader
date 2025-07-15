shader_type canvas_item;


uniform float progress : hint_range(0, 1) = 1.0; // 初始值设为1（完全可见）
uniform sampler2D noise_texture : filter_nearest;
uniform float edge_width : hint_range(0, 0.5) = 0.1;
uniform vec4 edge_color : source_color = vec4(1.0, 0.5, 0.0, 1.0);


void fragment() {
    float noise_value = texture(noise_texture, UV).r;
    
    // 反向溶解逻辑：当噪波值大于progress时显示内容
    if (noise_value > progress) {
        discard; // 溶解部分变为透明
    }
    
    vec4 tex_color = texture(TEXTURE, UV);
    COLOR = tex_color;
    
    // 边缘效果（仅在溶解边缘显示）
    if (noise_value > progress - edge_width && noise_value <= progress) {
        float edge_factor = (progress - noise_value) / edge_width;
        COLOR = mix(edge_color, tex_color, edge_factor);
    }
}
