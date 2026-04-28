shader_type canvas_item;

uniform float alpha_boost : hint_range(0.0, 5.0) = 2.0;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    float a = clamp(tex.a * alpha_boost, 0.0, 1.0);
    COLOR = vec4(1.0, 1.0, 1.0, a);
}