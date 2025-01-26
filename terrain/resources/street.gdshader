shader_type canvas_item;
uniform sampler2D grass_texture;

void fragment() {
    
	vec2 uv = FRAGCOORD.xy / TEXTURE_PIXEL_SIZE;

    // Sample the grass texture
    vec4 grass_color = texture(grass_texture, uv);

    // Mix with a background color or transparency if necessary
    COLOR = grass_color;
}