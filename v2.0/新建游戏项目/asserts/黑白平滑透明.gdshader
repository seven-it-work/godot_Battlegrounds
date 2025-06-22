shader_type canvas_item;

uniform float fade_range : hint_range(0,0.5) = 0.1; // 过渡范围
uniform float white_cutoff : hint_range(0,1) = 0.85; // 白色起始阈值
uniform float black_cutoff : hint_range(0,1) = 0.15; // 黑色结束阈值

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    float brightness = dot(color.rgb, vec3(0.2126, 0.7152, 0.0722)); // sRGB亮度计算

    // 白色渐变透明（平滑过渡）
    float white_alpha = 1.0 - smoothstep(
        white_cutoff - fade_range,
        white_cutoff + fade_range,
        brightness
    );

    // 黑色渐变透明（平滑过渡）
    float black_alpha = smoothstep(
        black_cutoff - fade_range,
        black_cutoff + fade_range,
        brightness
    );

    // 合并效果
    color.a = min(white_alpha, black_alpha);
    COLOR = color;
}