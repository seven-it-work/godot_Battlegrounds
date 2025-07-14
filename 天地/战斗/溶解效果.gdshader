shader_type canvas_item;

uniform sampler2D noise_tex : source_color, filter_nearest;
uniform float progress : hint_range(0.0, 1.0) = 0.0;
uniform float edge_width : hint_range(0.0, 0.2) = 0.1;
// 移除了source_color标记，手动控制颜色空间
uniform vec4 edge_color:source_color;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    
    if (progress < 0.001) {
        COLOR = tex_color;
    } else {
        float noise = texture(noise_tex, UV).r;
        float visible = step(progress, noise);
        float edge = smoothstep(
            max(0.0, progress - edge_width),
            progress + edge_width,
            noise
        );
        
        float glow = edge - visible;
        
        // 手动应用颜色（确保RGB顺序正确）
        vec3 edge_effect = vec3(
            edge_color.r * glow * 3.0,
            edge_color.g * glow * 3.0,
            edge_color.b * glow * 3.0 
        );
        
        COLOR.rgb = tex_color.rgb * visible + abs(edge_effect-vec3(0.00000, 0.00000, 0.00000));
        COLOR.a = tex_color.a * visible;
        
        if (visible <= 0.0) {
            COLOR.a = 0.0;
        }
    }
}