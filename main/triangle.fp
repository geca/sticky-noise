uniform vec4 u_color;
varying highp vec2 var_texcoord;

// Faster hash function (cheaper than sin)
float hash(vec2 p) {
	p = 50.0 * fract(p * 0.3183099);
	return fract(p.x * p.y * (p.x + p.y));
}

// Simplified value noise
float noise2d(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);

	// Cubic interpolation for smoother results with fewer samples
	vec2 u = f * f * (3.0 - 2.0 * f);

	// 4 corners
	float a = hash(i);
	float b = hash(i + vec2(1.0, 0.0));
	float c = hash(i + vec2(0.0, 1.0));
	float d = hash(i + vec2(1.0, 1.0));

	// Mix 4 corners
	return mix(
		mix(a, b, u.x),
		mix(c, d, u.x),
		u.y
	);
}

void main() {
	// Use a single layer of noise with carefully chosen frequency
	vec2 scaled_uv = var_texcoord * 100.0;
	float n = noise2d(scaled_uv);

	// Optional: Add a second layer with minimal cost
	float n2 = noise2d(scaled_uv * 2.0 + 5.0) * 0.5;
	float combined = (n + n2) * 0.67;

	// Apply a subtle mix - just enough to create variation
	float subtleNoise = mix(0.95, 1.0, combined);

	gl_FragColor = vec4(vec3(subtleNoise), 1.0);
}