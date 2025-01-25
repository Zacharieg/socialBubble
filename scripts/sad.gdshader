shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform sampler2D vortex_texture;
uniform float saturation = 0.25;
uniform float brightness_change = -0.2;

void fragment() {
	vec4 default_color = texture(TEXTURE, UV);
	vec2 vortex_uv = UV / 0.5 - vec2(0.498);
	vec4 vortex = texture(vortex_texture, vortex_uv);

	float brightness = (default_color.r + default_color.g + default_color.b)/3. + brightness_change;

	vec4 desaturated_color = (
		vec4(brightness, brightness, brightness, 1.) * (1. - saturation)
		+ default_color * saturation
	);

	COLOR = default_color * vortex + desaturated_color * (1. - vortex);
	//COLOR = vec4(vortex_uv.x, vortex_uv.y, 1,1);
}
