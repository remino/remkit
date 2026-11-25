// Uneven brightness for Ghostty
// Simulates broad, irregular variations in CRT luminance.

// Strength of brightness variation (0.0–1.0).
// Recommended: 0.03–0.08.
const float INTENSITY = 0.06;

// Size of brightness variations relative to the screen.
// Lower values produce larger, broader patches.
// Recommended: 2.0–5.0.
const float SCALE = 3.0;

// Number of noise layers contributing to the pattern.
// Higher values introduce more spatial detail.
// Recommended: 2–4.
const int OCTAVES = 3;

// Contrast of brightness variations.
// 1.0 is neutral; higher values emphasise extremes.
const float CONTRAST = 1.0;

// Seed for changing the stationary brightness pattern.
const float SEED = 42.0;

// Deterministic pseudorandom generator.
float hash(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

// Smooth two-dimensional value noise.
float valueNoise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);

    f = f * f * (3.0 - 2.0 * f);

    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));

    return mix(
        mix(a, b, f.x),
        mix(c, d, f.x),
        f.y
    );
}

// Fractal Brownian motion for natural-looking variation.
float fbm(vec2 p) {
    float value = 0.0;
    float amplitude = 0.5;
    float totalAmplitude = 0.0;

    for (int i = 0; i < OCTAVES; i++) {
        value += valueNoise(p) * amplitude;
        totalAmplitude += amplitude;

        p *= 2.0;
        amplitude *= 0.5;
    }

    return value / totalAmplitude;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 original = texture(iChannel0, uv);

    // Correct for aspect ratio so patterns remain circular.
    vec2 position = uv * vec2(
        iResolution.x / iResolution.y,
        1.0
    );

    // Generate a stationary, irregular brightness field.
    float brightness = fbm(
        position * SCALE + vec2(SEED, SEED * 0.37)
    );

    // Centre variation around zero.
    float variation = (brightness - 0.5) * 2.0;

    // Adjust contrast without changing the sign.
    variation = sign(variation) *
        pow(abs(variation), CONTRAST);

    // Modulate existing light rather than adding brightness.
    // Completely black pixels remain black.
    float modulation = 1.0 + variation * INTENSITY;

    vec3 color = original.rgb * modulation;

    fragColor = vec4(
        clamp(color, 0.0, 1.0),
        original.a
    );
}
