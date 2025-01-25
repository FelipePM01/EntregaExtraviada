shader_type canvas_item;

uniform float vignette_size : hint_range(0.0, 2.0) = 0.5;
uniform float intensity : hint_range(0.0, 1.0) = 1.0;
uniform float softness : hint_range(0.0, 1.0) = 0.5;
uniform vec4 vignette_color : source_color = vec4(0.0,0.0,0.0,1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV - vec2(0.5);
	float dist = length(uv);
	float vignette = 1.0 - smoothstep(vignette_size*(1.0 - softness),vignette_size,dist);
	COLOR = mix(vignette_color,vec4(0.0,0.0,0.0,0.0),vignette*intensity);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
