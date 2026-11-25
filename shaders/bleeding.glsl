// Horizontal light bleeding for Ghostty
// Simulates analogue signal smearing towards the right.

// Strength of the bleeding effect (0.0–1.0).
const float INTENSITY = 0.25;

// Maximum horizontal bleeding distance in pixels.
const float DISTANCE = 5.0;

// How quickly the bleeding fades (higher = faster).
const float DECAY = 0.65;

// Minimum brightness required to produce bleeding.
const float THRESHOLD = 0.2;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec2 texel = 1.0 / iResolution.xy;

    vec4 original = texture(iChannel0, uv);

    vec3 bleed = vec3(0.0);
    float totalWeight = 0.0;

    // Sample pixels to the left to create a rightward trail.
    for (int i = 1; i <= 12; i++) {
        float distance = float(i) / 12.0 * DISTANCE;

        vec2 offset = vec2(distance * texel.x, 0.0);

        vec3 sampleColor = texture(
            iChannel0,
            uv - offset
        ).rgb;

        float brightness = max(
            max(sampleColor.r, sampleColor.g),
            sampleColor.b
        );

        float contribution = smoothstep(
            THRESHOLD,
            THRESHOLD + 0.3,
            brightness
        );

        float weight = exp(-distance * DECAY);

        bleed += sampleColor * contribution * weight;
        totalWeight += weight;
    }

    bleed /= max(totalWeight, 0.0001);

    // Add the bleeding without replacing the original pixels.
    vec3 color = original.rgb + bleed * INTENSITY;

    fragColor = vec4(
        clamp(color, 0.0, 1.0),
        original.a
    );
}
