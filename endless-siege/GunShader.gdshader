shader_type canvas_item;

uniform float progress: hint_range(0.0, 1.0) = 0.0;
uniform vec3 outline_c: source_color = vec3(1.0, 0.0, 0.0);

void fragment() {
	COLOR = mix(COLOR, vec4(outline_c, COLOR.a), progress * (1.0 - COLOR.a));
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
