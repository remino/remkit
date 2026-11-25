// Shadow mask for Ghostty
// Simulates the repeating phosphor structure of a CRT.

// Mask strength (0.0–1.0).
const float INTENSITY = 0.18;

// Width of each phosphor element in physical pixels.
// Recommended: 1.0–3.0.
const float ELEMENT_SIZE = 2.0;

// 0 = monochrome mask, 1 = RGB shadow mask.
const int MASK_TYPE = 0;

// Minimum brightness of masked phosphor elements.
// Prevents the mask from becoming excessively dark.
const float MIN_BRIGHTNESS = 0.65;

// Controls the softness of transitions between elements.
// 0.0 = hard edges; 1.0 = very soft.
const float SOFTNESS = 0.35;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 original = texture(iChannel0, uv);

    float position = fragCoord.x / ELEMENT_SIZE;
    float phase = fract(position);

    // Soft transitions between phosphor elements.
    float edge = min(phase, 1.0 - phase);

    float mask = smoothstep(
        0.0,
        max(SOFTNESS * 0.5, 0.0001),
        edge
    );

    vec3 modulation;

    if (MASK_TYPE == 1) {
        // Repeating RGB phosphor triads.
        float element = mod(floor(position), 3.0);

        vec3 phosphor = vec3(
            1.0 - step(0.5, abs(element - 0.0)),
            1.0 - step(0.5, abs(element - 1.0)),
            1.0 - step(0.5, abs(element - 2.0))
        );

        modulation = mix(
            vec3(MIN_BRIGHTNESS),
            phosphor,
            mask
        );
    } else {
        // Neutral vertical phosphor structure.
        modulation = vec3(
            mix(MIN_BRIGHTNESS, 1.0, mask)
        );
    }

    vec3 color = original.rgb * mix(
        vec3(1.0),
        modulation,
        INTENSITY
    );

    fragColor = vec4(color, original.a);
}
