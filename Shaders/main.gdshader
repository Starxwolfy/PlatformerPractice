

shader_type canvas_item;

uniform vec4 flash_color: source_color = vec4(1, 0, 0, 1);
uniform float intens = 0.0;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	float brightness = dot(tex.rgb, vec3(1, 1, 1));
	vec3 adjusted_mix_color = flash_color.rgb * brightness;
	vec3 final_color = mix(tex.rgb, adjusted_mix_color, intens);
	COLOR.rgb = final_color.rgb;



	
	
}
