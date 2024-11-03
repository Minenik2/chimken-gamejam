shader_type canvas_item;

uniform float outline_size = 2.0;
uniform vec4 outline_color : hint_color = vec4(1.0, 1.0, 1.0, 1.0); // White color

void fragment() {
    // Sample the texture and get its alpha
    vec4 tex_color = texture(TEXTURE, FRAGCOORD.xy / SCREEN_PIXEL_SIZE);
    float alpha = tex_color.a;
    
    // If the pixel is not fully transparent, show the texture color
    if (alpha > 0.0) {
        COLOR = tex_color;
        return;
    }

    // Outline effect: sample surrounding pixels and apply color if any have alpha > 0
    for (float x = -outline_size; x <= outline_size; x += 1.0) {
        for (float y = -outline_size; y <= outline_size; y += 1.0) {
            vec2 offset = vec2(x, y) / SCREEN_PIXEL_SIZE;
            if (texture(TEXTURE, FRAGCOORD.xy / SCREEN_PIXEL_SIZE + offset).a > 0.0) {
                COLOR = outline_color;
                return;
            }
        }
    }

    // Default color if no outline is needed
    COLOR = tex_color;
}