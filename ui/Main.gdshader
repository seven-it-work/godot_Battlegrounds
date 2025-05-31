shader_type canvas_item;

void fragment() {
    // 获取UV坐标
    vec2 uv = UV;
    
    // 中心点
    vec2 center = vec2(0.5, 0.5);
    
    // 椭圆方程 (x/a)^2 + (y/b)^2 <= 1
    float a = 0.5; // 水平半径
    float b = 0.5; // 垂直半径
    
    // 计算是否在椭圆内
    float ellipse = pow((uv.x - center.x)/a, 2.0) + pow((uv.y - center.y)/b, 2.0);
    
    if (ellipse > 1.0) {
        discard; // 丢弃椭圆外的像素
    } else {
        COLOR = texture(TEXTURE, uv); // 显示椭圆内的纹理
    }
}