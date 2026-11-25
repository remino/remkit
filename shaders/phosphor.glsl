// Phosphor texture for Ghostty
// Simulates microscopic variations in phosphor brightness.

// Texture strength (0.0–1.0).
const float INTENSITY = 0.12;

// Approximate size of phosphor grains in physical pixels.
const float GRAIN_SIZE = 1.5;

// Controls the contrast of individual grains.
// Higher values produce more pronounced bright and dark spots.
const float CONTRAST = 1.0;

// Mix between fine and coarse texture (0.0–1.0).
const float COARSENESS = 0.3;

// Deterministic pseudorandom value.
float hash(vec2 p) {
    return fract(
        sin(dot(p, vec2(127.1, 311.7))) *
        43758.5453
    );
}

// Smoothly interpolated spatial noise.
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

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 original = texture(iChannel0, uv);

    // Fine phosphor grain.
    float fine = hash(
        floor(fragCoord / GRAIN_SIZE)
    );

    // Larger, smoothly varying phosphor irregularities.
    float coarse = valueNoise(
        fragCoord / (GRAIN_SIZE * 4.0)
    );

    // Combine the two spatial frequencies.
    float grain = mix(
        fine,
        coarse,
        COARSENESS
    );

    // Centre the variation around zero.
    float variation = (grain - 0.5) * 2.0;

    // Apply contrast.
    variation = sign(variation) *
        pow(abs(variation), CONTRAST);

    // Modulate the original light intensity.
    float modulation = 1.0 + variation * INTENSITY;

    vec3 color = original.rgb * modulation;

    fragColor = vec4(
        clamp(color, 0.0, 1.0),
        original.a
    );
}
