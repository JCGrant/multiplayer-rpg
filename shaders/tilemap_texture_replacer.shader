shader_type canvas_item;

const float EPSILON = 0.0000001;

uniform float cell_quadrant_size = 16.0;
uniform vec3 color_to_replace = vec3(255.0, 0, 255.0); // Magenta as default
uniform sampler2D texture_to_replace_with;

varying vec2 vert;

void vertex() {
    vert = VERTEX;
}

vec2 get_tile_uv() {
	return mod(vert / cell_quadrant_size, 1.0);
}

bool vec3_equal(vec3 a, vec3 b) {
	return abs(b.x - a.x) < EPSILON && abs(b.y - a.y) < EPSILON && abs(b.z - a.z) < EPSILON;
}

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec2 tile_uv = get_tile_uv();
	vec4 replaced_color = texture(texture_to_replace_with, tile_uv);

	vec3 normalized_color_to_replace = color_to_replace / 255.0;
	if (vec3_equal(color.rgb, normalized_color_to_replace)) {
		COLOR = replaced_color;
	} else {
		COLOR = color;
	}
}