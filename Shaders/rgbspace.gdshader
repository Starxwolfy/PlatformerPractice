shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_nearest;

void fragment() {
	vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	vec3 col_limit = floor(screen_color.rgb*5.0)/5.0;

	
	COLOR = vec4(col_limit, 1.0);
}
