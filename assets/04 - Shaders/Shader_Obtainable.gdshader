shader_type canvas_item;

group_uniforms Settings;
uniform bool do_abs;
uniform vec2 sine_amplitude = vec2(1.0, 0.0);
uniform vec2 sine_speed = vec2(1.0, 0.0);

void vertex() {
	vec2 s = sin(TIME * sine_speed);
	if (do_abs) {
		s = abs(s);
	}
	VERTEX += s * sine_amplitude;
}