varying highp vec2 var_pos;
float random(vec2 p) {
	return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}
void main() {
	float noise = random(var_pos * 10.0);
	float brightness = 1.0 + (noise - 0.5) * .20;
	gl_FragColor = vec4(vec3(brightness), 1.0);
}